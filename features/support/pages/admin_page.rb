class AdminPage
  include PageObject

  page_url "#{FigNewton.base_url}/admin"

  button(:add_new_account, text: 'Add Account')
  text_field(:new_account, id: 'new_account_name')
  text_field(:new_account_balance, id: 'new_account_balance')

  def add_account(account, balance)
    self.new_account = account
    self.new_account_balance = balance
    self.add_new_account
  end

end
