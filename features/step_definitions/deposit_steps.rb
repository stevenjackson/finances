Given(/^I have a deposit for \$(\d+)$/) do |amount|
  @database.insert_deposit(amount)
end

When(/^I distribute the deposit$/) do |table|
  visit(DepositPage)
  table.rows.each do | category, amount |
    on(DepositPage).assign(category, amount)
  end
  on(DepositPage).save
end
