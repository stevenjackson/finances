class DepositPage
  include PageObject

  image(:add, :alt => 'Plus')
  button(:save, :text => "Save")

  def assign(category, amount)
    text_field_elements(:class => 'category').last.value=category
    text_field_elements(:class => 'amount').last.value=amount
    add_element.click
  end

  def amount_for(category)
    text_field_element(:class => 'category', :text => category).parent.parent.text_field_element(:class => 'amount').value
  end
end
