require 'spec_helper'

describe Dwolla do
  its(:endpoint) { should == "https://www.dwolla.com/oauth/rest/testapi" }
  its(:user_agent) { should == "Dwolla Ruby Wrapper" }
  it { should_not be_debugging }
end
