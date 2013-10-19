class AdminController < ApplicationController
  def index
    @accounts = GetAccountBalances.new(gateway).run
    @balances = GetCategoryBalances.new(gateway).run
  end

  def save
    case params[:commit]
    when "Add Account"
      save_account
    when "Add Category"
      save_category
    end

    redirect_to :action => :index
  end

  def save_account
    account_info = { name: params[:new_account_name], balance: params[:new_account_balance] }
    CreateAccount.new(gateway).run account_info
  end

  def save_category
    category_info = { name: params[:new_category_name], budget: params[:new_category_budget] }
    CreateCategory.new(gateway).run category_info
  end
end
