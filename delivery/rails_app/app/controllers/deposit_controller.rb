class DepositController < ApplicationController
  def index
    @deposits = GetDeposits.new(gateway).run
  end

  def edit
    @deposit =  {:id => '1', :description => 'things', :amount => 600 }
  end
end
