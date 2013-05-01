class DepositPage
  include PageObject

  page_url "#{FigNewton.base_url}/deposit"

  image(:add, :alt => 'Plus')
  button(:save, :text => "Save")

  def assign(category, amount)
    text_field_elements(:class => 'category').last.value=category
    text_field_elements(:class => 'amount').last.value=amount
    add_element.click
  end
end
