class Finances::GetBalanceSheetTotals
  include Finances::DateParams

  def initialize(gateway)
    @gateway = gateway
  end

  def run(params={})
    @month, @year = parse_date params

    { debits: total_debits, credits: total_credits }
  end

  def total_debits
    @gateway.debits.select { |debit| debit.in_month?(@month, @year) }.reduce(0) { |sum, debit| sum += debit.amount }
  end

  def total_credits
    @gateway.credits.select { |credit| credit.in_month?(@month, @year) }.reduce(0) { |sum, credit| sum += credit.amount }
  end
end
