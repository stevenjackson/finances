class DepositPage
  include PageObject
  include TimeHelper

  image(:add, :alt => 'Plus')
  image(:delete, :alt => 'Delete')
  button(:save, :text => "Save")
  text_field(:month, :name => 'applied_month')
  text_field(:year, :name => 'applied_year')

  def apply_to_this_month
    self.month = this_month_string
    self.year = this_year
  end

  def assign(category, amount)
    text_field_elements(:class => 'category').last.value=category
    text_field_elements(:class => 'amount').last.value=amount
    add_element.click
  end

  def amount_for(category)
    row_for(category).text_field_element(:class => 'amount').value
  end

  def delete_all
    while(delete?)
      delete_element.click
    end
    save
  end

  def row_for(category)
    text_field_element(:class => 'category', :text => category).parent.parent
  end
end
