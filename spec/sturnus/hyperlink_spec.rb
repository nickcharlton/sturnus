require "spec_helper"

RSpec.describe Sturnus::Hyperlink do
  describe ".get" do
    context "when setup with a valid resource url" do
      it "calls #get on the relevant model" do
        class Example
          def self.get; end
        end

        allow(Sturnus).to receive(:models).and_return(
          "examples" => Example,
        )
        allow(Example).to receive(:get)

        link = described_class.new("api/v1/examples", false)
        link.get

        expect(Example).to have_received(:get)
      end
    end

    context "when setup with an unknown url" do
      it "returns nil" do
        link = described_class.new("api/v1/examples", false)

        expect(link.get).to be_nil
      end
    end
  end
end
