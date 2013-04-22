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
    @db[:transactions].insert :description => "Trans", :amount => amount
  end
end
