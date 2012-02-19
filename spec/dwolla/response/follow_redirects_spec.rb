require 'spec_helper'
require 'forwardable'

describe Dwolla::Response::FollowRedirects do

 before do
    @conn = Faraday.new do |b|
      b.use Dwolla::Response::FollowRedirects
      b.adapter :test do |stub|
        stub.get('/') { [301, {'Location' => '/found'}, ''] }
        stub.post('/create') { [302, {'Location' => '/'}, ''] }
        stub.get('/found') { [200, {'Content-Type' => 'text/plain'}, 'fin'] }
        stub.get('/loop') { [302, {'Location' => '/loop'}, ''] }
        stub.get('/temp') { [307, {'Location' => '/found'}, ''] }
      end
    end
  end

  extend Forwardable
  def_delegators :@conn, :get, :post
  
  it 'follow one redirect' do
    get('/').body.should == 'fin'
  end
  
  it 'follow twice redirect' do
    post('/create').body.should == 'fin'
  end

  it 'follows 307 redirects' do
    get('/temp').body.should == 'fin'
  end
  
  it 'has a redirect limit' do
    expect { get('/loop') }.to raise_error(Dwolla::Response::RedirectLimitReached)
  end  
end

