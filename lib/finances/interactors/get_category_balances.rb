class Finances::GetCategoryBalances
  def initialize(gateway)
    @gateway = gateway
  end
  def run
    balances = {}
    @gateway.categories.each do |category|
      balances[category.name.to_sym] = calculate_balance category
    end
    balances
  end

  def calculate_balance(category)
    total_spent = by_category(@gateway.debits, category).map(&:amount).reduce(0, :+)
    total_deposited = by_category(@gateway.credits, category).map(&:amount).reduce(0, :+)
    category.budget - total_spent + total_deposited
  end

  def by_category(items, category)
    items.select { |i| category.name == i.category }
  end
end
