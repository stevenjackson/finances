class Finances::GetCategoryBalanceSheet
  include Finances::DateParams
  def initialize(gateway)
    @gateway = gateway
  end

  def run(params={})
    @month, @year = parse_date params
    categories.map { |c| balance(c) }
  end

  def categories()
    @gateway.categories
  end

  def balance(category)
    {
        category: category.name,
        spent: amount_spent(category),
        budget: category.budget,
        remainder: amount_added(category) - amount_spent(category)
    }
  end

  def amount_spent(category)
    total(@gateway.debits, category)
  end

  def amount_added(category)
    total(@gateway.credits, category)
  end

  def total(items, category)
    by_month(items, category).map(&:amount).reduce(0, :+)
  end

  def by_month(items, category)
    items.select { |i| i.matches? category.name, @month, @year }
  end
end
