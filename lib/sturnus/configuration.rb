module Sturnus
  class Configuration
    attr_accessor :client_id, :client_secret, :redirect_uri,
                  :access_token, :environment

    def initialize(opts = {})
      opts.each do |k, v|
        send("#{k}=".to_sym, v)
      end
    end

    def environment
      @environment ||= :production
    end

    def endpoint
      case environment
      when :sandbox
        "https://api-sandbox.starlingbank.com"
      when :production
        "https://api.starlingbank.com"
      end
    end

    def to_h
      {
        client_id: client_id,
        client_secret: client_secret,
        redirect_uri: redirect_uri,
        access_token: access_token,
        environment: environment,
      }
    end

    def to_s
      objects = to_h.map { |k, v| "#{k}=#{v}" }.join(" ")
      "#<#{self.class.name}:#{object_id} #{objects}"
    end
  end

  class << self
    attr_accessor :configuration
  end

  def self.configure
    yield configuration if block_given?
  end

  def self.configuration
    @configuration ||= Configuration.new
  end
end
