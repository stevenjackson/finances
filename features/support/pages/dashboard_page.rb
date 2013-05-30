class DashboardPage
  include PageObject

  page_url FigNewton.base_url

  def balance(category)
    div_element(:id => "#{category}_balance").text
  end

  def unsorted_transactions_count(account)
    text = div_element(:id => "#{account}_unsorted").text
    text =~ /has (\d+) unsorted/
    $1.to_i
  end

  def unsorted_transactions_amount(account)
    text = div_element(:id => "#{account}_unsorted").text
    text =~ /\$(\d+)$/
    $1.to_i
  end
end
