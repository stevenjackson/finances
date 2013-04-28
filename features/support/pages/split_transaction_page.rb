class SplitTransactionPage
  include PageObject

  text_field(:category, :class => 'category')
  text_field(:amount, :class => 'amount')
  image(:add, :alt => 'Plus')
  button(:save, :text => "Save")

  def assign(category, amount, index=0)
    text_field_element(:class => 'category', :index => index).value=category
    text_field_element(:class => 'amount', :index => index).value=amount
    add_element.click
  end

end
