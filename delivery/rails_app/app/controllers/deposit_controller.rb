class DepositController < ApplicationController
  def index
    @unsorted_deposits = [ {:id => '1', :description => 'things', :amount => 600 }]
  end
end
