require "spec_helper"

RSpec.describe Sturnus::Configuration do
  it "has configured accessors" do
    expect(config).to have_attributes(
      client_id: "abc",
      client_secret: "xyz",
      redirect_uri: "https://example.com/redirect",
      access_token: "123",
    )
  end

  describe "#environment" do
    it "is :production when not set" do
      config = described_class.new

      expect(config.environment).to eq(:production)
    end

    it "can be set" do
      config = described_class.new(environment: :something_else)

      expect(config.environment).to eq(:something_else)
    end
  end

  describe "#endpoint" do
    it "has the correct value when in sandbox" do
      config = described_class.new(environment: :sandbox)

      expect(config.endpoint).
        to eq("https://api-sandbox.starlingbank.com")
    end

    it "has the correct value when in production" do
      config = described_class.new(environment: :production)

      expect(config.endpoint).to eq("https://api.starlingbank.com")
    end
  end

  describe "#to_h" do
    it "has a hash representation" do
      expect(config.to_h).to eq(
        client_id: "abc",
        client_secret: "xyz",
        redirect_uri: "https://example.com/redirect",
        access_token: "123",
        environment: :production,
      )
    end
  end

  def config
    Sturnus::Configuration.new(
      client_id: "abc",
      client_secret: "xyz",
      redirect_uri: "https://example.com/redirect",
      access_token: "123",
    )
  end
end
