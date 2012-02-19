require 'spec_helper'

describe Dwolla do
  its(:endpoint) { should == "https://www.dwolla.com/oauth/rest" }
  its(:user_agent) { should == "Dwolla Ruby Wrapper" }

  describe 'debugging' do
    after do
      Dwolla.debug = false 
    end

    it { should_not be_debugging }

    it 'should be debugging' do
      Dwolla.debug = true
      Dwolla.should be_debugging
    end
  end
end
