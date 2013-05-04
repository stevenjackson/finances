class DepositController < ApplicationController
  def index
    @deposits = GetDeposits.new(gateway).run
  end

  def edit
    @deposit = index.find { |t| t[:id].to_s == params[:id]  }
  end
end
