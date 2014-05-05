class TransactionPage
  include PageObject

  page_url "#{FigNewton.base_url}/transaction"

  table(:transactions)
  text_field(:first_category, :index => 0)
  button(:assign, :text => 'Assign')

  def assign_first_transaction_to(category)
    first_transaction.click
    self.first_category = category
    self.assign
  end

  def split_first_transaction
    first_transaction.click
    first_transaction.send_keys '/'
  end

  def first_transaction
    transactions_element.cell_element
  end

  def unsorted_count
    return transactions_element.select { |row| transaction? row }.count
  end

  def transaction? row
    row.attribute(:class).include? 'transaction_row'
  end
end
