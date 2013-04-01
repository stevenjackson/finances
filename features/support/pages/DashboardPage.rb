class DashboardPage
  include PageObject

  def balance(category)
    div_element(:id => "#{category}_balance").text
  end
end
