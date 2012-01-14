module Dwolla
  class User
    include Dwolla::Connection

    attr_accessor :id,
                  :name,
                  :latitude,
                  :longitude,
                  :city,
                  :state,
                  :type,
                  :access_token

    def initialize(attrs={})
      update_attributes(attrs)
    end

    def self.me(access_token)
      User.new(:name => 'me', :access_token => access_token)
    end

    def fetch
      user_attributes_hash = get('/oauth/rest/users')
      update_attributes(user_attributes_hash)
      self
    end

    def update_attributes(attrs)
      attrs.each do |key, value|
        send("#{key.downcase}=".to_sym, value)
      end
    end

    def balance
      get('/oauth/rest/balance')
    end

    private

      def query_params
        "?access_token=#{self.access_token}"
      end
   end
end
