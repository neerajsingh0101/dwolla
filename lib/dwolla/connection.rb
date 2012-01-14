module Dwolla
  module Connection
    private
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
