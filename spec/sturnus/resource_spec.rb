require "spec_helper"

RSpec.describe Sturnus::Resource do
  describe "links" do
    it "builds a hash of links from a response" do
      response = {
        "self" => {
          "href" => "api/v1/customers",
          "templated" => false,
        },
      }

      resource = described_class.new
      resource._links = response

      links_self = resource._links["self"]
      expect(links_self).to have_attributes(
        link: "api/v1/customers",
        templated: false,
      )
    end
  end
end
