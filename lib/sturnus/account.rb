module Sturnus
  class Account < Resource
    URL = "/api/v1/accounts".freeze

    attr_accessor :id, :name, :number, :sort_code, :currency,
      :iban, :bic, :created_at

    def self.get(opts = {})
      response = Sturnus.client.get(URL, opts)

      Representers::Account.new(new).from_json(response.body)
    end
  end
end
