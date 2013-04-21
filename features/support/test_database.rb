require 'fig_newton'
require 'sequel'

class TestDatabase
  def initialize
    @db = Sequel.connect(DB_URI)
    initialize_schemas
  end

  def initialize_schemas
    @db.create_table? :categories do
        primary_key :id
        String :name
        FixNum :budget
    end

    @db.create_table? :debits do
      primary_key :id
      String :category
      FixNum :amount
    end
    
    @db.create_table? :transactions do
      primary_key :id
      String :description
      FixNum :amount
    end
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
