require 'spec_helper'

describe Dwolla::Transaction do
  describe "send transaction" do
    before do
      @origin = double(:oauth_token => '1')
      @destination = '2'

      @payload = { :destinationId => '2',
                   :amount => 200,
                   :pin => '1234',
                   :oauth_token => '1' }

      stub_post('/transactions/send').with(:body => MultiJson.encode(@payload)).to_return(
        :body => fixture('send_transaction.json'))
    end

    it "should request the correct resource" do
      transaction = Dwolla::Transaction.new(:origin => @origin,
                                            :destination => @destination,
                                            :type => :send,
                                            :amount => 200,
                                            :pin => '1234')
      transaction.execute

      a_post('/transactions/send').
        with(:body => MultiJson.encode(@payload)).should have_been_made
    end

    it "should fetch the id if transaction succesfull" do
      transaction = Dwolla::Transaction.new(:origin => @origin,
                                            :destination => @destination,
                                            :type => :send,
                                            :amount => 200,
                                            :pin => '1234')

      transaction.execute.should == 12345
      transaction.id.should == 12345
    end
  end

  describe "request transaction" do
    before do
      @origin = double(:oauth_token => '1')
      @destination = '2'

      @payload = { :destinationId => '2',
                   :amount => 200,
                   :pin => '1234',
                   :oauth_token => '1' }

      stub_post('/transactions/request').with(:body => MultiJson.encode(@payload)).to_return(
        :body => fixture('request_transaction.json'))
    end

    it "should request the correct resource" do
      transaction = Dwolla::Transaction.new(:origin => @origin,
                                            :destination => @destination,
                                            :type => :request,
                                            :amount => 200,
                                            :pin => '1234')
      transaction.execute

      a_post('/transactions/request').
        with(:body => MultiJson.encode(@payload)).should have_been_made
    end

    it "should fetch the id if transaction succesfull" do
      transaction = Dwolla::Transaction.new(:origin => @origin,
                                            :destination => @destination,
                                            :type => :request,
                                            :amount => 200,
                                            :pin => '1234')

      transaction.execute.should == 12345
      transaction.id.should == 12345
    end
  end
end
