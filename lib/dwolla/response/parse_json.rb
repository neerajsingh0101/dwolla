module Dwolla
  module Response
    class ParseJson < Faraday::Response::Middleware
      def on_complete(env)
        if respond_to? :parse
          env[:body] = parse(env[:body]) unless [204,302,304,307].index env[:status]
        end
      end

      def parse(body)
        case body
        when ''
          nil
        else
          response_hash = ::MultiJson.load(body)

          raise Dwolla::RequestException, response_hash["Message"] if response_hash["Success"] == false

          response_hash["Response"] ||
            response_hash["SendResult"] ||
              response_hash["RequestResult"] ||
                response_hash
        end
      end
    end
  end
end
