module Dwolla
  module Connection
    private
      def connection(options = {})
        default_options = {
          :headers => {
            :accept => 'application/json',
            :user_agent => Dwolla.user_agent,
          },
          :url => options.fetch(:endpoint, Dwolla.endpoint),
        }

        @connection ||= Faraday.new(default_options.merge(options)) do |builder|
          builder.use Dwolla::Response::ParseJson
          builder.adapter :net_http
        end
      end

      def get(path, params={}, options={})
        request(:get, path, params, options)
      end

      def post(path, params={}, options={})
        request(:post, path, params, options)
      end

      def request(method, path, params, options)
        response = connection(options).send(method) do |request|
          case method.to_sym
          when :delete, :get
            request.url(path, params.merge(auth_params))
          when :post
            request.path = path
            params.merge(auth_params) if auth_params
            request.body = params unless params.empty?
          end
        end
        options[:raw] ? response : response.body
      end
  end
end
