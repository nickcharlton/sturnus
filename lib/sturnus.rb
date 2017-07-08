require "oauth2"
require "representable"
require "representable/coercion"

require "sturnus/version"
require "sturnus/errors"
require "sturnus/configuration"
require "sturnus/client"
require "sturnus/hyperlink"
require "sturnus/resource"
require "sturnus/representers/base"

require "sturnus/representers/customer"
require "sturnus/customer"
require "sturnus/representers/account"
require "sturnus/account"

module Sturnus
  attr_accessor :client

  def self.client
    @client ||= Client.new(configuration)
  end

  def self.models
    {
      "accounts" => Account,
      "customers" => Customer,
    }
  end
end
