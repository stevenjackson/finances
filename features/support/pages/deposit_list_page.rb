class DepositListPage
  include PageObject

  page_url "#{FigNewton.base_url}/deposit"
  table :deposits, id: 'deposits'

  def unsorted_count
    deposits_element.rows
  end

  def show_first
    deposits_element.link_element.click
  end
end
