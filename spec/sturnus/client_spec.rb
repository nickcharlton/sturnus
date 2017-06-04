require "spec_helper"

RSpec.describe Sturnus::Client do
  describe "#authorize_url" do
    it "creates a URL for the user to be redirected to" do
      client = described_class.new(oauth_config)

      expect(client.authorize_url).to eq("https://oauth.starlingbank.com" \
        "/oauth/authorize?client_id=abc&" \
        "redirect_uri=https%3A%2F%2Fexample.com%2Fredirect&response_type=code")
    end
  end

  describe "#exchange_token" do
    it "gets an access token for an authorisation code" do
      stub_request(:post, "https://api.starlingbank.com/oauth/access-token").
        with(body: { "client_id" => "abc", "client_secret" => "xyz",
                     "code" => "1234567890abcdefghikjlmnopqrstuvwxyz",
                     "grant_type" => "authorization_code",
                     "redirect_url" => "https://example.com/redirect" }).
        to_return(body: fixture("oauth_access_token.json"),
                  status: 200,
                  headers: { "Content-Type" => "application/json" })

      client = described_class.new(oauth_config)
      token = client.exchange_token("1234567890abcdefghikjlmnopqrstuvwxyz")

      expect(token).to have_attributes(
        token: "bW3kAkyNWCYUvNG6QFBLoiZc1YbGGblvLFW9FYvNzMF0FAidxNo" \
                "PZP5gsN1T3NiS",
        refresh_token: "Km9frBk55jnZdY9RZktUfyFPTDi8JUWwdPdDwG68yjW" \
                "Ye2c8RVuTtrtjJ46eTl5M",
        expires_in: 3600,
      )
    end
  end

  describe "#token" do
    context "when an access token comes from an OAuth flow" do
      it "has the access token from exchange_token" do
        stub_request(:post, "https://api.starlingbank.com/oauth/access-token").
          with(body: { "client_id" => "abc", "client_secret" => "xyz",
                       "code" => "1234567890abcdefghikjlmnopqrstuvwxyz",
                       "grant_type" => "authorization_code",
                       "redirect_url" => "https://example.com/redirect" }).
          to_return(body: fixture("oauth_access_token.json"),
                    status: 200,
                    headers: { "Content-Type" => "application/json" })

        client = described_class.new(oauth_config)
        client.exchange_token("1234567890abcdefghikjlmnopqrstuvwxyz")
        token = client.token

        expect(token).to have_attributes(
          token: "bW3kAkyNWCYUvNG6QFBLoiZc1YbGGblvLFW9FYvNzMF0FAidxNo" \
            "PZP5gsN1T3NiS",
          expires_in: 3600,
        )
      end
    end

    context "when an access token is provided directly" do
      it "has the access token from the configuration" do
        client = described_class.new(personal_token_config)
        token = client.token

        expect(token).to have_attributes(token: "abc", expires_in: nil)
      end
    end
  end

  describe "#get" do
    it "raises an error if the token isn't set" do
      client = described_class.new(oauth_config)

      expect do
        client.get("/api/v1/me")
      end.to raise_error(Sturnus::Errors::AuthenticationError,
                         "missing access token")
    end

    it "makes a request using the token" do
      config = personal_token_config
      stub_request(:get, "#{config.endpoint}/api/v1/me").
        to_return(body: fixture("v1_me.json"), status: 200)

      client = described_class.new(config)
      response = client.get("/api/v1/me")

      expect(response).to have_attributes(status: 200, error: nil)
    end
  end

  def oauth_config
    Sturnus::Configuration.new(
      client_id: "abc",
      client_secret: "xyz",
      redirect_uri: "https://example.com/redirect",
    )
  end

  def personal_token_config
    Sturnus::Configuration.new(access_token: "abc")
  end
end
