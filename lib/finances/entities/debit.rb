class Finances::Debit
  attr_reader :category, :amount

  def initialize(category, amount)
    @category = category
    @amount = amount
  end
end
