module Dwolla
  class Transaction
    include Dwolla::Connection

    ENDPOINTS = { :send => '/oauth/rest/transactions/send' }

    attr_accessor :origin, :destination, :type, :amount, :pin

    def initialize(attrs = {})
      attrs.each do |key, value|
        send("#{key}=".to_sym, value)
      end
    end

    def execute
      post(ENDPOINTS[type], to_payload)
    end

    private

      def auth_params
        { :oauth_token => origin.oauth_token }
      end

      def to_payload
        { :destinationId => destination.id,
          :amount => amount,
          :pin => pin }
      end
  end
end
