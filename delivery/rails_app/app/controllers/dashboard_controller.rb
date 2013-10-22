class DashboardController < ApplicationController
  def home
    @balances = GetCategoryBalances.new(gateway).run
    @accounts = GetAccountBalances.new(gateway).run
    @unsorted_transactions = GetUnsortedTransactionAccountSummary.new(gateway).run
    @unsorted_transactions = { :checking => { count: 2, amount: 35  } }
  end

  def month
    @categories = GetCategoryBalanceSheet.new(gateway).run params
    @accounts = GetAccountBalanceSheet.new(gateway).run params
    @totals = GetBalanceSheetTotals.new(gateway).run params
    @month = Date.strptime("#{params[:year] || Date.today.year }-#{params[:month]}", '%Y-%B')
  end
end
