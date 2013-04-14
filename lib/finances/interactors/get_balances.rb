class Finances::GetBalances
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
    total_spent = @gateway.debits.select { |debit| category.name == debit.category }.reduce(0){ |sum, debit| sum + debit.amount}
    category.budget - total_spent
  end
end
