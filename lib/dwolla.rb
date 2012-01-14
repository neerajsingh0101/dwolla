require 'faraday'

module Dwolla
  def self.endpoint=(endpoint)
    @@endpoint = endpoint
  end

  def self.endpoint
    @@endpoint
  end

  self.endpoint = "https://www.dwolla.com"
end

require "dwolla/response/parse_json"
require "dwolla/connection"
require "dwolla/client"
require "dwolla/user"
require "dwolla/version"
