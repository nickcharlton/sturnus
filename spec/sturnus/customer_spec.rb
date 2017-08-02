require "spec_helper"

RSpec.describe Sturnus::Customer do
  before do
    Sturnus.configure do |config|
      config.environment = :sandbox
      config.access_token = "abc"
    end
  end

  describe ".get" do
    it "fetches the current customer" do
      stub_request(:get, build_url("/api/v1/customers")).
        to_return(body: fixture("v1_customers.json"), status: 200)

      customer = described_class.get

      expect(customer).to have_attributes(
        uid: "40e5cf47-9774-405a-9193-35f002d9c8ef",
        first_name: "Dirk",
        last_name: "Gently",
        date_of_birth: Date.new(1960, 1, 1),
        email: "40e5cf47-9774-405a-9193-35f002d9c8ef@starlingbank.com",
        phone: "40e5cf47-9774-405a-9193-35f002",
      )
    end

    it "links to self" do
      stub_request(:get, build_url("/api/v1/customers")).
        to_return(body: fixture("v1_customers.json"), status: 200)

      customer = described_class.get

      expect(customer._links["self"].get).to have_attributes(
        uid: "40e5cf47-9774-405a-9193-35f002d9c8ef",
        first_name: "Dirk",
        last_name: "Gently",
      )
    end

    it "links to accounts" do
      stub_request(:get, build_url("/api/v1/customers")).
        to_return(body: fixture("v1_customers.json"), status: 200)
      stub_request(:get, build_url("/api/v1/accounts")).
        to_return(body: fixture("v1_accounts.json"), status: 200)

      customer = described_class.get
      account = customer._links["accounts"].get

      expect(account).to have_attributes(
        id: "0469acc8-572a-467e-877b-306b71e1d16b",
        name: "18c0cf35-6d7d-4b80-9ee7-10baaea6021a GBP",
        number: "12345678",
        sort_code: "123456",
      )
    end
  end
end
