Given(/^I have a deposit for \$(\d+)$/) do |amount|
  @database.insert_deposit(amount)
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

Then(/I should see the deposit:$/) do |table|
  visit(DepositListPage).show_first
  table.rows.each do | category, amount |
    on(DepositPage).amount_for(category).should == amount
  end
end
