class SplitTransactionPage
  include PageObject

  text_field(:category, :id => 'category')
  text_field(:amount, :id => 'amount')
  button(:assign, :text => 'Assign')

  def assign(category, amount)
    self.category = category
    self.amount = amount
    self.assign
  end
end
