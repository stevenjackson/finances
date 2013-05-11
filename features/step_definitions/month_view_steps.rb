When /^I have a credit for \$(\d+) in "(.*?)" last month$/ do |amount, category|
  #Not sure how to capture this idea yet - deposits are applied to next month (to fill the envelope for next month)
  @database.credit_category category, amount, this_month
end


When /^I have a debit for \$(\d+) in "(.*?)" this month$/ do |amount, category|
  @database.debit_category category, amount, this_month
end

Then(/^I should see categories for this month:$/) do |table|
  visit(MonthPage)

  actual_table = []
  table.rows.each do | category, budget, spent, remainder |
    actual_table << {
      'category' => category,
      'budget' => on(MonthPage).budget_for(category),
      'spent' => on(MonthPage).spent_for(category),
      'remainder' => on(MonthPage).remainder_for(category) }
  end
  table.diff! actual_table
end

Given /^I have a balance of \$(\d+) for "(.*?)" last month$/ do |amount, account|
  @database.insert_account account
  @database.store_balance account, amount, last_month
end

When /^I spend \$(\d+) from "(.*?)" this month$/ do |amount, account|
  @database.debit_account account, amount, this_month
end

Then /^I should see accounts for this month:$/ do |table|
  visit(MonthPage)

  actual_table = []
  table.rows.each do | account, starting, ending, change|
    actual_table << {
      'account' => account,
      'start' => on(MonthPage).starting_balance_for(account),
      'end' => on(MonthPage).ending_balance_for(account),
      'change' => on(MonthPage).account_change(account) }
  end
  table.diff! actual_table
end

Then /^I should see \$(\d+) for deposits this month$/ do |amount|
  visit(MonthPage).total_deposits.should == amount
end

Then /^I should see \$(\d+) for expenses this month$/ do |amount|
  visit(MonthPage).total_expenses.should == amount
end
