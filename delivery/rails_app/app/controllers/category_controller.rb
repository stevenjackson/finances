class CategoryController < ApplicationController
  respond_to :json
  def index
    @categories = GetCategoryBalances.new(gateway).run
    @categories = @categories.map { |key, value| Hash[:name, key, :amount, value] }
    respond_with @categories
  end

end
