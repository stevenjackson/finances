Given(/^I have a transaction for \$(\d+)$/) do |amount|
  @database.insert_transaction(amount)
end

Given(/^I have some expenses$/) do 
  (Random.rand(1..10)).times do
    @database.insert_transaction(Random.rand(2000))
  end
end

Then(/^I should see (\d+) outstanding transactions?$/) do |count|
  visit(TransactionPage).unsorted_count.should == count.to_i
end

When(/^I assign the transaction to "(.*?)"$/) do |category|
  visit(TransactionPage).assign_first_transaction_to category
end

When(/^I split the transaction$/) do |table|
  visit(TransactionPage).split_first_transaction 
  table.rows.each_with_index.map { |a, index| [a[0], a[1], index] }.each do |category, amount, index|
    on(SplitTransactionPage).assign(category, amount, index)
  end
  on(SplitTransactionPage).save
end

Then /^I should see (\d+) unsorted transactions for "(.*?)" totaling \$(\d+)$/ do |number, account, amount|
  visit(DashboardPage).unsorted_transactions_count(account).should == number.to_i
  on(DashboardPage).unsorted_transactions_amount(account).should == amount.to_i
end
