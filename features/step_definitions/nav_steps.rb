When /^I visit the site$/ do
  visit(DashboardPage)
end

Then /^I should see a way to get started$/ do
  on(DashboardPage).getting_started?.should be_true
end
