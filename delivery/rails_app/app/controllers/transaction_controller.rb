class TransactionController < ApplicationController
  def index
    @unsorted_transactions = GetUnsortedExpenses.new(gateway).run
  end

  def assign
    if(params[:split])
      redirect_to split_transaction_path(params[:transaction_id])
    else
      AssignTransaction.new(gateway).run(params)
      redirect_to :action => :index
    end
  end

  def split
    @transaction = index.find { |t| t[:id].to_s == params[:id]  }
  end

  def save_splits
    h = {}
    h[:debits] = []
    h[:transaction_id] = params[:id]
    params[:category].each_with_index do |category, index|
      amount = params[:amount][index]
      unless amount.split.empty?
        h[:debits] << { category: category, amount: amount}
      end
    end
    SplitTransaction.new(gateway).run(h)
    redirect_to :action => :index
  end
end
