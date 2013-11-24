When /^I visit the site$/ do
  visit(DashboardPage)
end

Then /^I should see a way to get started$/ do
  on(DashboardPage).getting_started?.should be_true
end

Then(/^I can get to "(.*?)" transactions from the dashboard$/) do |account|
  visit(DashboardPage).view_unsorted_for account
  on(TransactionPage).count.should be > 0
end
