require 'spec_helper'

describe Dwolla do
  its(:endpoint) { should be_eql("https://www.dwolla.com/oauth/rest/testapi") }
end
