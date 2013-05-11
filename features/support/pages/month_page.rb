class MonthPage
  include PageObject

  page_url "#{FigNewton.base_url}/#{Time.new.strftime("%B")}"

  def budget_for(category)
    category_value category, 'budget'
  end

  def spent_for(category)
    category_value category, 'spent'
  end

  def remainder_for(category)
    category_value category, 'remainder'
  end

  def starting_balance_for(account)
    account_value account, 'starting'
  end

  def ending_balance_for(account)
    account_value account, 'ending'
  end

  def account_change(account)
    account_value account, 'change'
  end

  private
  def category_value(category, type)
    category_row_for(category).cell_element(:class => type).text
  end

  def category_row_for(category)
    cell_element(:class => 'category', :text => category).parent
  end

  def account_value(account, type)
    account_row_for(account).cell_element(:class => type).text
  end

  def account_row_for(account)
    cell_element(:class => 'account', :text => account).parent
  end
end
