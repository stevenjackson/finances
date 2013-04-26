class SplitTransactionPage
  include PageObject

  text_field(:category, :class => 'category')
  text_field(:amount, :class => 'amount')

  def assign(category, amount)
    self.category = category
    self.amount = amount
  end
end
