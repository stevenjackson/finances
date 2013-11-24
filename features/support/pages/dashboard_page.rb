class DashboardPage
  include PageObject

  page_url FigNewton.base_url

  link(:getting_started, :text => 'Getting Started')

  def balance(category)
    div_element(:id => "#{category}_balance").text
  end

  def unsorted_transactions_count(account)
    text = unsorted_div(account).text
    text =~ /has (\d+) unsorted/
    $1.to_i
  end

  def unsorted_transactions_amount(account)
    text = unsorted_div(account).text
    text =~ /\$(\d+)$/
    $1.to_i
  end

  def view_unsorted_for(account)
    unsorted_div(account).link_element.click
  end

  def unsorted_div(account)
    div_element(:id => "#{account}_unsorted")
  end
end
