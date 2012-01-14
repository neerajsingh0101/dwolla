require 'spec_helper'

describe Dwolla::User do
  let(:access_token) { 'valid_token' } 
  let(:query_params) { "access_token=#{access_token}" }

  describe "fetching your full account information" do
    before do
      stub_get('/oauth/rest/users', query_params).
        to_return(:body => fixture("account_information.json"))
    end

    it "should request the correct resource" do
      user = Dwolla::User.me(access_token).fetch

      a_get('/oauth/rest/users', query_params).should have_been_made
    end

    it "should return full information of a given user" do
      user = Dwolla::User.me(access_token).fetch

      user.should be_a Dwolla::User
      user.id.should == '812-111-1111'
      user.name.should == 'Test User'
      user.latitude.should == 41.584546
      user.longitude.should == -93.634167
      user.city.should == 'Des Moines'
      user.state.should == 'IA'
      user.type.should == 'Personal'
      user.access_token.should == access_token
    end
  end

  it "should know your balance" do
    stub_get('/oauth/rest/balance', query_params).
      to_return(:body => fixture("balance.json"))

    user = Dwolla::User.me(access_token)
    user.balance.should == 55.76
  end
end
