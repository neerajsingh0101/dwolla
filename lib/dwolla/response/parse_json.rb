require 'faraday'
require 'multi_json'

module Dwolla
  module Response
    class ParseJson < Faraday::Response::Middleware
      def parse(body)
        case body
        when ''
          nil
        else
          response_hash = ::MultiJson.decode(body)
          response_hash["Response"]
        end
      end
    end
  end
end
