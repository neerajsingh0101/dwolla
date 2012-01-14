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
        url = resource
        url += "?" unless resource =~ /\?/
        url += query_params
        response = connection.get(url)
        response.body
      end
  end
end
