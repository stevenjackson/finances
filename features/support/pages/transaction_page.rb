class TransactionPage
  include PageObject

  page_url "#{FigNewton.base_url}/transaction"

  table(:transactions)
  text_field(:first_category, :index => 0)
  button(:assign, :text => 'Assign')

  def assign_first_transaction_to(category)
    transactions_element.first.click
    self.first_category = category
    self.assign
  end

  def count
    return transactions_element.rows
  end

  def split_first_transaction
    transactions_element.first.click
    transactions_element.send_keys '/'
  end

end
