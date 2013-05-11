class Finances::GetCategoryBalanceSheet
  def initialize(gateway)
    @gateway = gateway
  end

  def run(params={})
    @month = parse_month params[:month]
    @year = params[:year] || Time.new.to_date.year
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
    @gateway.categories(@month, @year)
  end

  def amount_spent(category)
    @gateway.debits.select{ |d| d.matches?(category.name, @month, @year) }.reduce(0) { |sum, d| sum + d.amount }
  end

  def amount_added(category)
    @gateway.credits.select{ |c| c.matches?(category.name, @month, @year) }.reduce(0) { |sum, c| sum + c.amount }
  end

  def parse_month(month) 
    case month
    when nil
      Time.new.to_date.month
    when String
      Date.strptime(month, "%b").month
    when Fixnum
      month
    end
  end
end
