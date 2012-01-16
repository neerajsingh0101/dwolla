module Dwolla
  class Transaction
    include Dwolla::Connection

    ENDPOINTS = { :send => 'transactions/send',
                  :request => 'transactions/request' }

    attr_accessor :origin, :destination, :type, :amount, :pin, :id

    def initialize(attrs = {})
      attrs.each do |key, value|
        send("#{key}=".to_sym, value)
      end
    end

    def execute
      self.id = post(ENDPOINTS[type], to_payload)
    end

    private

      def auth_params
        { :oauth_token => origin.oauth_token }
      end

      def to_payload
        { :destinationId => destination,
          :amount => amount,
          :pin => pin }
      end
  end
end
