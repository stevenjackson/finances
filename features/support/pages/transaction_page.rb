class TransactionPage
  include PageObject

  page_url "http://localhost:3000/transaction"

  table(:transactions)
  text_field(:first_category, :index => 0)
  button(:assign, :text => 'assign')

  def assign_first_transaction_to(category)
    self.first_category = category
    self.assign
  end

  def count
    return transactions.rows.count
  end

end
