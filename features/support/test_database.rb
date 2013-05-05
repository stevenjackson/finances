require 'fig_newton'
require 'sequel'

class TestDatabase
  def initialize
    @db = Sequel.connect(DB_URI)
  end

  def insert_category(category, amount)
    @db[:categories].insert :name => category, :budget => amount
  end

  def debit_category(category, amount)
    @db[:debits].insert :category => category, :amount => amount
  end

  def insert_transaction(amount)
    @db[:transactions].insert :description => "Trans", :amount => "-#{amount}"
  end

  def insert_deposit(amount)
    @db[:transactions].insert :description => "Deposit", :amount => amount
  end

  def insert_account(account, balance)
    @db[:accounts].insert :name => account, :balance => balance
  end

  def debit_account(account, amount)
    account_id = @db[:accounts][:name => account][:id]
    @db[:transactions].insert :description => "Trans", :amount => "-#{amount}", :account_id => account_id
  end
end
