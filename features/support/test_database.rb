require 'fig_newton'
require 'sequel'

class TestDatabase
  def initialize
    @db = Sequel.connect(DB_URI)
  end

  def insert_category(category, amount)
    @db[:categories].insert :name => category, :budget => amount
  end

  def debit_category(category, amount, date_applied=Time.now)
    @db[:debits].insert :category => category, :amount => amount, :date_applied => date_applied
  end

  def credit_category(category, amount, date_applied=Time.now)
    @db[:credits].insert :category => category, :amount => amount, :date_applied => date_applied
  end

  def insert_transaction(amount)
    @db[:transactions].insert :description => "Trans", :amount => "-#{amount}", :posted_at => Time.now
  end

  def insert_deposit(amount)
    @db[:transactions].insert :description => "Deposit", :amount => amount
  end

  def insert_account(account, balance=0)
    @db[:accounts].insert :name => account, :balance => balance
  end

  def debit_account(account, amount, date=Time.now)
    account_id = @db[:accounts][:name => account][:id]
    @db[:transactions].insert :description => "Trans", :amount => "-#{amount}", :account_id => account_id, :posted_at => date
  end

  def store_balance(account, amount, date)
    account_id = @db[:accounts][:name => account][:id]
    @db[:account_balances].insert :account_id => account_id, :balance => amount, :date => date
  end
end
