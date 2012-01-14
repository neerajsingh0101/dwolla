require 'faraday'

module Dwolla
  def self.endpoint=(endpoint)
    @@endpoint = endpoint
  end

  def self.endpoint
    @@endpoint
  end

  def self.user_agent=(user_agent)
    @@user_agent = user_agent
  end

  def self.user_agent
    @@user_agent
  end

  self.user_agent = "Dwolla Ruby Wrapper"
  self.endpoint = "https://www.dwolla.com"
end

require "dwolla/response/parse_json"
require "dwolla/connection"
require "dwolla/client"
require "dwolla/transaction"
require "dwolla/user"
require "dwolla/version"
