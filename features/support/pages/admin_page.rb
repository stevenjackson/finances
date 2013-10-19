class AdminPage
  include PageObject

  page_url "#{FigNewton.base_url}/admin"

  button(:add_new_account, text: 'Add Account')
  text_field(:new_account, id: 'new_account_name')
  text_field(:new_account_balance, id: 'new_account_balance')

  button(:add_new_category, text: 'Add Category')
  text_field(:new_category, id: 'new_category_name')
  text_field(:new_category_budget, id: 'new_category_budget')

  def add_account(account, balance)
    self.new_account = account
    self.new_account_balance = balance
    self.add_new_account
  end

  def add_category(category, budget)
    self.new_category = category
    self.new_category_budget = budget
    self.add_new_category
  end

end
