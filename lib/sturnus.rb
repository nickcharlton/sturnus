require "oauth2"

require "sturnus/version"
require "sturnus/errors"
require "sturnus/configuration"
require "sturnus/client"

module Sturnus
  attr_accessor :client

  def self.client
    @client ||= Client.new(configuration)
  end
end
