module Dwolla
  class Client
    def initialize(client, secret)
      @client, @secret = client, secret
    end

    def user(id)
      user_hash = get("/users/#{id}")
      User.new(user_hash)
    end

    private

      def query_params
        "?client_id=#{@client}&client_secret=#{@secret}"
      end

      def connection
        @connection ||= Faraday.new(:url => Dwolla.endpoint) do |builder|
          builder.use Dwolla::Response::ParseJson
          builder.adapter :net_http
        end
      end

      def get(resource)
        response = connection.get(resource + query_params)
        response.body
      end
  end
end
