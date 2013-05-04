class DepositController < ApplicationController
  def index
    @deposits = GetDeposits.new(gateway).run
  end

  def edit
    @deposit = index.find { |t| t[:id].to_s == params[:id]  }
  end
  
  def update
    h = {}
    h[:credits] = []
    h[:transaction_id] = params[:id]
    params[:category].each_with_index do |category, index|
      amount = params[:amount][index]
      h[:credits] << { category: category, amount: amount}
    end
    DistributeDeposit.new(gateway).run(h)
    redirect_to :action => :edit
  end

end
