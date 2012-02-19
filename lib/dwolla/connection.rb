module Dwolla
  module Connection
    private
      def connection
        default_options = {
          :headers => {
            :accept => 'application/json',
            :content_type => 'application/json',
            :user_agent => Dwolla.user_agent,
          }
        }

        @connection ||= Faraday.new(Dwolla.endpoint, default_options) do |builder|
          builder.use Dwolla::Response::FollowRedirects
          builder.use Dwolla::Response::ParseJson

          builder.use Faraday::Request::UrlEncoded

          builder.response :logger if Dwolla.debugging?
          builder.adapter Faraday.default_adapter
        end
      end

      def get(path, params={})
        request(:get, path, params)
      end

      def post(path, params={})
        request(:post, path, params)
      end

      def request(method, path, params)
        response = connection.send(method) do |request|
          case method.to_sym
          when :delete, :get
            request.url(path, params.merge(auth_params))
          when :post
            request.path = path
            params.merge!(auth_params) if auth_params
            request.body = MultiJson.encode(params) unless params.empty?
          end
        end
        response.body
      end
  end
end
