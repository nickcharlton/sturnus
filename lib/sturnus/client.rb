module Sturnus
  class Client
    include Sturnus::Errors

    def initialize(config)
      @configuration = config
      @oauth_client = OAuth2::Client.new(
        config.client_id,
        config.client_secret,
        site: config.endpoint,
        authorize_url: "https://oauth.starlingbank.com/oauth/authorize",
        token_url: "https://api.starlingbank.com/oauth/access-token",
      )
    end

    def authorize_url
      oauth_client.auth_code.authorize_url(redirect_uri:
        configuration.redirect_uri)
    end

    def exchange_token(code)
      @token = oauth_client.auth_code.get_token(
        code,
        redirect_url: configuration.redirect_uri,
      )
    end

    def token
      @token ||= OAuth2::AccessToken.new(oauth_client,
                                         configuration.access_token)
    end

    %w(get put post delete).each do |m|
      define_method(m) do |path, opts = {}|
        validate!

        token.request(m.to_sym, path, opts)
      end
    end

    private

    attr_reader :configuration, :oauth_client

    def validate!
      if token.token.empty?
        raise AuthenticationError, "missing access token"
      end
    end
  end
end
