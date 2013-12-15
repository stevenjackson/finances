class Finances::GetExpenseBalanceSheet
  include Finances::DateParams
  def initialize(gateway)
    @gateway = gateway
  end

  def run(params={})
    @month, @year = parse_date params
    debits.map { |d| to_expense(d) }
  end

  def debits
    @gateway.debits.select do |debit|
      if debit.date_applied
        debit_date = debit.date_applied.to_date
        debit_date.month == @month and debit_date.year == @year
      end
    end
  end

  def to_expense(debit)
    {
      amount: debit.amount,
      description: transaction_description_for(debit),
      category: debit.category,
      date: short_date_for(debit.date_applied)
    }
  end

  def transaction_description_for(debit)
    transaction = @gateway.transaction_by_id(debit.transaction_id)
    transaction ? transaction.description : 'Unknown'
  end

end
