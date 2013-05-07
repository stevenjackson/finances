Given /^I have a budget of \$(\d+) for "(.*?)"$/ do |budget, category|
  @database.insert_category(category, budget)
end

When(/^I spend \$(\d+) of "(.*?)"$/) do |amount, category|
  @database.debit_category(category, amount)
end

Then(/^I should see \$(\d+) for "(.*?)"$/) do |amount, category|
  visit(DashboardPage).balance(category).should eq amount
end
