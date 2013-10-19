class Finances::CreateCategory
  include Finances
  def initialize(gateway)
    @gateway = gateway
  end

  def run(params)
    return if @gateway.categories.any? { |category| category.name == params[:name] }
    @gateway.save Category.new params
  end
end
