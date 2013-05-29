class Finances::GetBalanceSheetTotals
  include Finances::DateParams

  def initialize(gateway)
    @gateway = gateway
  end

  def run(params={})
    @month, @year = parse_date params

    { debits: debit_balance, credits: credit_balance }
  end

  def debit_balance
    total @gateway.debits
  end

  def credit_balance
    total @gateway.credits
  end

  def total(items)
    items.select { |item| item.in_month?(@month, @year) }.map(&:amount).reduce(0, :+)
  end
end
