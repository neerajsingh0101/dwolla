require "rack/oauth2"

module Dwolla
  ROOT_URL = "https://www.dwolla.com"

  mattr_accessor :logger

  self.logger = Logger.new(STDOUT)

  def self.debugging?
    @@debugging
  end

  def self.debugging=(boolean)
    Rack::OAuth2.debugging = boolean
    @@debugging = boolean
  end

  self.debugging = false

  def self.debug!
    Rack::OAuth2.debug!
    self.debugging = true
  end

  def self.debug(&block)
    rack_oauth2_original = Rack::OAuth2.debugging?
    original = self.debugging?
    debug!
    yield
  ensure
    Rack::OAuth2.debugging = rack_oauth2_original
    self.debugging = original
  end
end

require "dwolla/version"
