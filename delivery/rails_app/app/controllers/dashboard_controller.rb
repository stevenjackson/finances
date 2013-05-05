class DashboardController < ApplicationController
  def home
    @balances = GetBalances.new(gateway).run
    @accounts = GetAccountBalances.new(gateway).run
  end
end
