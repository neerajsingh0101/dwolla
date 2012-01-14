module Dwolla
  class User
    attr_accessor :id, :name, :latitude, :longitude

    def initialize(attrs={})
      attrs.each do |key, value|
        send("#{key.downcase}=".to_sym, value)
      end
    end
  end
end
