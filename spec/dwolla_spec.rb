require 'spec_helper'

describe Dwolla do
  subject { Dwolla }
  after { Dwolla.debugging = false }

  its(:logger) { should be_a Logger }
  its(:debugging?) { should be_false }

  describe '.debug!' do
    before { Dwolla.debug! }
    its(:debugging?) { should be_true }
  end

  describe '.debug' do
    it 'should enable debugging within given block' do
      Dwolla.debug do
        Rack::OAuth2.debugging?.should be_true
        Dwolla.debugging?.should be_true
      end

      Rack::OAuth2.debugging?.should be_false
      Dwolla.debugging?.should be_false
    end

    it 'should not force disable debugging' do
      Rack::OAuth2.debug!
      Dwolla.debug!

      Dwolla.debug do
        Rack::OAuth2.debugging?.should be_true
        Dwolla.debugging?.should be_true
      end

      Rack::OAuth2.debugging?.should be_true
      Dwolla.debugging?.should be_true
    end
  end
end
