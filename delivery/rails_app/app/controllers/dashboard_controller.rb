class DashboardController < ApplicationController
  def home
    @balances = GetCategoryBalances.new(gateway).run
    @accounts = GetAccountBalances.new(gateway).run
  end

  def month
    @categories = GetCategoryBalanceSheet.new(gateway).run params
    @accounts = GetAccountBalanceSheet.new(gateway).run params
    @totals = GetBalanceSheetTotals.new(gateway).run params
  end
end
