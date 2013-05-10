class Finances::GetCategoryBalanceSheet
  def initialize(gateway)
    @gateway = gateway
  end

  def run(params={})
    month = params[:month] || Time.new.to_date.month
    year = params[:year] || Time.new.to_date.year
    categories(month, year).map do |c|
    { category: c.name,
        spent: amount_spent(c, month, year),
        budget: c.budget,
        remainder: (c.budget - amount_spent(c, month, year))
    }
    end 
  end

  def categories(month, year)
    @gateway.categories(month, year)
  end

  def amount_spent(category, month, year)
    @gateway.debits.select{ |d| d.matches?(category.name, month, year) }.reduce(0) { |sum, d| sum + d.amount }
  end
end
