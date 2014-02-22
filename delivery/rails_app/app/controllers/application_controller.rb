require 'gateway_factory'
require 'finances'
class ApplicationController < ActionController::Base
  include Finances
  protect_from_forgery

  helper_method :gateway, :to_date

  def gateway
    ::GatewayFactory.create ENV["RAILS_ENV"]
  end

  def to_date month='', year=''
    year = Integer(year) rescue nil
    month = Date::MONTHNAMES.index(month) || Date::ABBR_MONTHNAMES.index(month)
    if month and year
      Date.new(year, month, 1).to_time
    end
  end
end
