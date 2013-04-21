class DashboardPage
  include PageObject

  page_url FigNewton.base_url

  def balance(category)
    div_element(:id => "#{category}_balance").text
  end
end
