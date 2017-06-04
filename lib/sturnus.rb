require "oauth2"
require "representable"
require "representable/coercion"

require "sturnus/version"
require "sturnus/errors"
require "sturnus/configuration"
require "sturnus/client"

require "sturnus/representers/customer"
require "sturnus/customer"

module Sturnus
  attr_accessor :client

  def self.client
    @client ||= Client.new(configuration)
  end
end
