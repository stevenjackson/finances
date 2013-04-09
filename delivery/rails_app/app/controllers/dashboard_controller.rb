class DashboardController < ApplicationController
  def home
    @balances = { groc: 40 }
  end
end
