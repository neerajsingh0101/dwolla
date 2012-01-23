require 'spec_helper'

describe Dwolla::User do
  let(:oauth_token) { 'valid_token' }
  let(:token_param) { "oauth_token=#{oauth_token}" }

  describe "fetching your full account information" do
    before do
      stub_get('/users', token_param).
        to_return(:body => fixture("account_information.json"))
    end

    it "should request the correct resource" do
      user = Dwolla::User.me(oauth_token).fetch

      a_get('/users', token_param).should have_been_made
    end

    it "should return full information" do
      user = Dwolla::User.me(oauth_token).fetch

      user.should be_a Dwolla::User
      user.id.should == '812-111-1111'
      user.name.should == 'Test User'
      user.latitude.should == 41.584546
      user.longitude.should == -93.634167
      user.city.should == 'Des Moines'
      user.state.should == 'IA'
      user.type.should == 'Personal'
      user.oauth_token.should == oauth_token
    end

    it "should raise a error if fetch failed" do
      stub_get('/users', token_param).
        to_return(:body => fixture("error.json"))

      expect{ Dwolla::User.me(oauth_token).fetch }.to
        raise_error(Dwolla::RequestException, "Token does not have access to requested resource.")
    end
  end

  describe "sending money" do
    it "should make the correct transaction" do
      user = Dwolla::User.new(:oauth_token => '12345', :id => '1')
      destination_user = Dwolla::User.new(:id => '2')
      amount = 10
      pin = '2222'


      transaction = double('transaction')
      transaction_id = 123

      Dwolla::Transaction.should_receive(:new).with(:origin => user,
                                            :destination => destination_user,
                                            :amount => 10,
                                            :type => :send,
                                            :pin => '2222').and_return(transaction)

      transaction.should_receive(:execute).and_return(transaction_id)

      user.send_money_to(destination_user, amount, pin).should == 123
    end
  end

  describe "requesting money" do
    it "should make the correct transaction" do
      user = Dwolla::User.new(:oauth_token => '12345', :id => '1')
      source_user_id = '2'
      amount = 10
      pin = '2222'

      transaction = double('transaction')
      transaction_id = 123

      Dwolla::Transaction.should_receive(:new).with(:origin => user,
                                                    :source => source_user_id,
                                                    :amount => 10,
                                                    :type => :request,
                                                    :pin => '2222').and_return(transaction)

      transaction.should_receive(:execute).and_return(transaction_id)

      user.request_money_from(source_user_id, amount, pin).should == 123
    end
  end

  it "knows his balance" do
    stub_get('/balance', token_param).
      to_return(:body => fixture("balance.json"))

    user = Dwolla::User.me(oauth_token)
    user.balance.should == 55.76
  end

  describe "contacts" do
    it "should request the correct resource when unfiltered" do
      user = Dwolla::User.me(oauth_token)

      stub_get('/contacts', token_param).
        to_return(:body => fixture("contacts.json"))

      user.contacts

      a_get('/contacts', token_param).should have_been_made
    end

    it "should request the correct resource when seaching by name" do
      user = Dwolla::User.me(oauth_token)

      stub_get("/contacts?search=Bob&#{token_param}").
        to_return(:body => fixture("contacts.json"))

      user.contacts(:search => 'Bob')

      a_get("/contacts?search=Bob&#{token_param}").should have_been_made
    end

    it "should request the correct resource when filtering by type" do
      user = Dwolla::User.me(oauth_token)

      stub_get("/contacts?type=Facebook&#{token_param}").
        to_return(:body => fixture("contacts.json"))

      user.contacts(:type => 'Facebook')

      a_get("/contacts?type=Facebook&#{token_param}").should have_been_made
    end

    it "should request the correct resource when limiting" do
      user = Dwolla::User.me(oauth_token)

      stub_get("/contacts?limit=2&#{token_param}").
        to_return(:body => fixture("contacts.json"))

      user.contacts(:limit => 2)

      a_get("/contacts?limit=2&#{token_param}").should have_been_made
    end

    it "should request the correct resource when using all together" do
      user = Dwolla::User.me(oauth_token)

      stub_get("/contacts?search=Bob&type=Facebook&limit=2&#{token_param}").
        to_return(:body => fixture("contacts.json"))

      user.contacts(:search => "Bob", :type => "Facebook", :limit => 2)

      a_get("/contacts?search=Bob&type=Facebook&limit=2&#{token_param}").should have_been_made
    end

    it "should return the contact users properly" do
      user = Dwolla::User.me(oauth_token)

      stub_get("/contacts", token_param).
        to_return(:body => fixture("contacts.json"))

      contacts = user.contacts

      first_contact = contacts.first

      first_contact.should be_a Dwolla::User
      first_contact.id.should == "12345"
      first_contact.name.should == "Ben Facebook Test"
      first_contact.image.should == "https://graph.facebook.com/12345/picture?type=square"
      first_contact.contact_type.should == "Facebook"

      second_contact = contacts.last

      second_contact.should be_a Dwolla::User
      second_contact.id.should == "812-111-1111"
      second_contact.name.should == "Ben Dwolla Test"
      second_contact.image.should == "https://www.dwolla.com/avatar.aspx?u=812-111-1111"
      second_contact.contact_type.should == "Dwolla"
    end
  end
end
