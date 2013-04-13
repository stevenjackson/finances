require 'finances'

class DashboardController < ApplicationController
  include Finances
  def home
    @balances = GetBalances.new.run
  end
end
