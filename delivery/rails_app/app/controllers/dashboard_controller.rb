class DashboardController < ApplicationController
  def home
    @balances = GetBalances.new(gateway).run
  end
end
