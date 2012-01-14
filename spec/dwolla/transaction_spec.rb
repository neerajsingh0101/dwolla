require 'spec_helper'
require 'pry'

describe Dwolla::Transaction do
  describe "send transaction" do
    before do
      @origin = double(:oauth_token => '1')
      @destination = double(:id => '2')

      @payload = { :oauth_token => '1',
                  :destinationId => '2',
                  :amount => '200',
                  :pin => '1234' }

      stub_post('/transactions/send').with(:body => @payload).to_return(
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
        with(:body => @payload).should have_been_made
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
      @destination = double(:id => '2')

      @payload = { :oauth_token => '1',
                   :destinationId => '2',
                   :amount => '200',
                   :pin => '1234' }

      stub_post('/transactions/request').with(:body => @payload).to_return(
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
        with(:body => @payload).should have_been_made
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
