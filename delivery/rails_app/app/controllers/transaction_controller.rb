class TransactionController < ApplicationController
  def index
    @unsorted_transactions = GetUnsortedTransactions.new(gateway).run
  end
  
  def assign
    puts params[:category]
    render 'index'
  end
end
