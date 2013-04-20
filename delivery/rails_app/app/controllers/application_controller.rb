require 'gateway_factory'
require 'finances'
class ApplicationController < ActionController::Base
  include Finances
  protect_from_forgery

  helper_method :gateway

  def gateway
    ::GatewayFactory.create ENV["RAILS_ENV"]
  end
end
