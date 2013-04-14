require_relative '../../../../gateway/gateway_factory'
class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :gateway

  def gateway
    ::GatewayFactory.create ENV["RAILS_ENV"]
  end
end
