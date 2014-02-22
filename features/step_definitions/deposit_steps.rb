Given(/^I have a deposit for \$(\d+)$/) do |amount|
  @database.insert_deposit(amount)
end

Given(/^I have some deposits$/) do 
  (Random.rand(1..10)).times do
    @database.insert_deposit(Random.rand(1..2000))
  end
end

When(/^I distribute the deposit$/) do |table|
  table.rows.each do | category, amount |
    @database.insert_category(category, 0)
  end
  visit(DepositListPage).show_first
  table.rows.each do | category, amount |
    on(DepositPage).assign(category, amount)
  end
  on(DepositPage).save
end

Then(/^I should see the deposit:$/) do |table|
  visit(DepositListPage).show_first
  table.rows.each do | category, amount |
    on(DepositPage).amount_for(category).should == amount
  end
end

When (/^I delete the credits$/) do
  visit(DepositListPage).show_first
  on(DepositPage).delete_all
end

When (/^I apply the deposit to this month$/) do
  on(DepositPage).apply_to_this_month
  on(DepositPage).save
end
