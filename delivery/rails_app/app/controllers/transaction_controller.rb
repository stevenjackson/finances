class TransactionController < ApplicationController
  def index
    @unsorted_transactions = GetUnsortedTransactions.new(gateway).run
  end
  
  def assign
    AssignTransaction.new(gateway).run(params)
    index
    render 'index'
  end
end
