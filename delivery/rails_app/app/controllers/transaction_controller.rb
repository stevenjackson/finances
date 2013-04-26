class TransactionController < ApplicationController
  def index
    @unsorted_transactions = GetUnsortedTransactions.new(gateway).run
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
end
