module Sturnus
  class Customer
    URL = "/api/v1/customers".freeze

    attr_accessor :uid, :first_name, :last_name, :date_of_birth, :email, :phone

    def self.get(opts = {})
      response = Sturnus.client.get(URL, opts)

      Representers::Customer.new(new).from_json(response.body)
    end
  end
end
