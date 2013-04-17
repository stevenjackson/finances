class DashboardPage
  include PageObject

  page_url "http://localhost:3000"

  def balance(category)
    div_element(:id => "#{category}_balance").text
  end
end
