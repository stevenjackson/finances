Given(/^I have a category for "(.*?)" with an amount of \$(\d+)$/) do |category, amount|
  @database.insert_category(category, amount)
end

When(/^I spend \$(\d+) of "(.*?)"$/) do |amount, category|
  @database.debit_category(category, amount)
end

Then(/^I should see \$(\d+) for "(.*?)"$/) do |amount, category|
  on(DashboardPage).balance(category).should eq amount
end
