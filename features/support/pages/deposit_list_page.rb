class DepositListPage
  include PageObject

  page_url "#{FigNewton.base_url}/deposit"

  link :show_first do |page|
    page.table_element(:id => 'unsorted_deposits').link_element
  end
end
