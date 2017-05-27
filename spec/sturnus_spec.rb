require "spec_helper"

RSpec.describe Sturnus do
  it "has a version number" do
    expect(Sturnus::VERSION).not_to be nil
  end

  describe "#configure" do
    it "yields a configuration object" do
      config = Sturnus::Configuration.new
      allow(Sturnus).to receive(:configuration).and_return(config)

      expect do |b|
        Sturnus.configure(&b)
      end.to yield_with_args(config)

      expect(Sturnus).to have_received(:configuration)
    end
  end

  describe "#configuration" do
    it "has a configuration" do
      expect(Sturnus.configuration).to be_a(Sturnus::Configuration)
    end
  end

  describe "#client" do
    it "has a client" do
      expect(Sturnus.client).to be_a(Sturnus::Client)
    end
  end
end
