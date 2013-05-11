class Finances::GetCategoryBalanceSheet
  include Finances::DateParams
  def initialize(gateway)
    @gateway = gateway
  end

  def run(params={})
    @month, @year = parse_date params
    categories.map do |c|
    {
        category: c.name,
        spent: amount_spent(c),
        budget: c.budget,
        remainder: amount_added(c) - amount_spent(c)
    }
    end 
  end

  def categories()
    @gateway.categories
  end

  def amount_spent(category)
    @gateway.debits.select{ |d| d.matches?(category.name, @month, @year) }.reduce(0) { |sum, d| sum + d.amount }
  end

  def amount_added(category)
    @gateway.credits.select{ |c| c.matches?(category.name, @month, @year) }.reduce(0) { |sum, c| sum + c.amount }
  end
end
