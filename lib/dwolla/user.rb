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
                  :contact_type,
                  :image,
                  :oauth_token

    def initialize(attrs={})
      update_attributes(attrs)
    end

    def self.me(access_token)
      User.new(:oauth_token => access_token)
    end

    def fetch
      user_attributes_hash = get('users')
      update_attributes(user_attributes_hash)
      self
    end

    def update_attributes(attrs)
      attrs.each do |key, value|
        send("#{key.downcase}=".to_sym, value)
      end
    end

    def balance
      get('balance')
    end

    def contacts(options = {})
      contacts_url = 'contacts'
      contacts = get(contacts_url, options)

      instances_from_contacts(contacts)
    end

    def send_money_to(destination, amount, pin)
      transaction = Transaction.new(:origin => self,
                                    :destination => destination,
                                    :type => :send,
                                    :amount => amount,
                                    :pin => pin)

      transaction.execute
    end

    def request_money_from(source, amount, pin)
      transaction = Transaction.new(:origin => self,
                                    :source => source,
                                    :type => :request,
                                    :amount => amount,
                                    :pin => pin)
      transaction.execute
    end

    private

      def instances_from_contacts(contacts)
        user_instances = []
        contacts.each do |contact|
          contact["Contact_Type"] = contact["Type"]
          contact.delete("Type")
          user_instances << User.new(contact)
        end
        user_instances
      end

      def auth_params
        { :oauth_token => self.oauth_token }
      end
   end
end
