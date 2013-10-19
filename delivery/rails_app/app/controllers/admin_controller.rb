class AdminController < ApplicationController
  def index
    @accounts = GetAccountBalances.new(gateway).run
    @balances = GetCategoryBalances.new(gateway).run
  end

  def save
    account_info = { name: params[:new_account_name], balance: params[:new_account_balance] }
    CreateAccount.new(gateway).run account_info
    redirect_to :action => :index
  end
end
