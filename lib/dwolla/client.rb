module Dwolla
  class Client
    include Dwolla::Connection

    def initialize(client, secret)
      @client, @secret = client, secret
    end

    def user(id)
      user_attributes_hash = get("accountinformation/#{id}")
      User.new(user_attributes_hash)
    end

    private

      def auth_params
        { :client_id => @client, :client_secret => @secret }
      end
   end
end
