require "spec_helper"

RSpec.describe Sturnus::Account do
  before do
    Sturnus.configure do |config|
      config.environment = :sandbox
      config.access_token = "abc"
    end
  end

  describe ".get" do
    it "fetches the current account" do
      stub_request(:get, build_url("/api/v1/accounts")).
        to_return(body: fixture("v1_accounts.json"), status: 200)

      account = described_class.get

      expect(account).to have_attributes(
        id: "0469acc8-572a-467e-877b-306b71e1d16b",
        name: "18c0cf35-6d7d-4b80-9ee7-10baaea6021a GBP",
        number: "12345678",
        sort_code: "123456",
        currency: "GBP",
        iban: "GB31SRLG12345612345678",
        bic: "SRLGGB2L",
        created_at: DateTime.new(2017, 5, 10, 0, 0, 0),
      )
    end

    it "links to self" do
      pending "the Starling API doesn't specify a self link on /v1/accounts"
      stub_request(:get, build_url("/api/v1/accounts")).
        to_return(body: fixture("v1_accounts.json"), status: 200)

      account = described_class.get

      expect(account._links["self"].get).to have_attributes(
        id: "0469acc8-572a-467e-877b-306b71e1d16b",
        name: "18c0cf35-6d7d-4b80-9ee7-10baaea6021a GBP",
        number: "12345678",
        sort_code: "123456",
      )
    end
  end
end
