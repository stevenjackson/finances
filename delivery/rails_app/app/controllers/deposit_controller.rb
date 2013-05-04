class DepositController < ApplicationController
  def index
    @unsorted_deposits = GetUnsortedDeposits.new(gateway).run 
  end

  def edit
    @deposit =  {:id => '1', :description => 'things', :amount => 600 }
  end
end
