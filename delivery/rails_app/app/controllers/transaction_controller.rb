class TransactionController < ApplicationController
  def assign
    puts params[:category]
    render 'index'
  end
end
