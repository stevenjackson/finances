require 'finances'

class DashboardController < ApplicationController
  include Finances
  def home
    @balances = GetBalances.new(gateway).run
  end
end
