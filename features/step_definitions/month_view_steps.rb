When /^I have a credit for \$(\d+) in "(.*?)" last month$/ do |amount, category|
  #Not sure how to capture this idea yet - deposits are applied to next month (to fill the envelope for next month)
  @database.credit_category category, amount, this_month
end


When /^I have a debit for \$(\d+) in "(.*?)" this month$/ do |amount, category|
  @database.debit_category category, amount, this_month
end

Then(/^I should see for this month:$/) do |expected_table|
  visit(MonthPage)

  actual_table = []
  expected_table.rows.each do | category, budget, spent, remainder |
    actual_table << {
      'category' => category,
      'budget' => on(MonthPage).budget_for(category),
      'spent' => on(MonthPage).spent_for(category),
      'remainder' => on(MonthPage).remainder_for(category) }
  end
  expected_table.diff! actual_table
end

