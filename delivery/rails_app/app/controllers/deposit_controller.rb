class DepositController < ApplicationController
  def index
    @deposits = GetDeposits.new(gateway).run
  end

  def edit
    transaction_id = params[:id].to_i
    @deposit = index.find { |t| t[:id] == transaction_id  }
    @credits = GetCredits.new(gateway).run(transaction_id: transaction_id)
  end

  def update
    h = { credits: [], transaction_id: params[:id].to_i }
    params[:category] ||= []
    params[:category].reject { |c| c.blank? }.each_with_index do |category, index|
      amount = params[:amount][index].to_i
      h[:credits] << { category: category, amount: amount}
    end
    DistributeDeposit.new(gateway).run(h)
    redirect_to :action => :edit
  end

end
