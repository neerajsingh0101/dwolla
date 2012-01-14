require 'spec_helper'

describe Dwolla::Transaction do
  describe "send transaction" do
    it "should request the correct resource" do
      origin = double(:oauth_token => '1')
      destination = double(:id => '2')

      payload = { :oauth_token => '1',
                  :destinationId => '2',
                  :amount => 200,
                  :pin => '1234' }

      stub_post('/oauth/rest/transactions/send').with(:body => payload)

      transaction = Dwolla::Transaction.new(:origin => origin,
                                            :destination => destination,
                                            :type => :send,
                                            :amount => 200,
                                            :pin => '1234')
      transaction.execute

      a_post('/oauth/rest/transactions/send').
        with(:body => payload).should have_been_made
    end
  end

  describe "request transaction" do
    it "should request the correct resource" do
    end
  end
end
