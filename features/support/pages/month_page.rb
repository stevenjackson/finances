class MonthPage
  include PageObject

  page_url "#{FigNewton.base_url}/month"

  def budget_for(category)
    value category, 'budget'
  end

  def spent_for(category)
    value category, 'spent'
  end

  def remainder_for(category)
    value category, 'remainder'
  end
 
  def value(category, type)
    row_for(category).cell_element(:class => type).text
  end

  def row_for(category)
    cell_element(:class => 'category', :text => category).parent.parent
  end
end
