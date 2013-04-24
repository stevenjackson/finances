Given(/^I have a transaction for \$(\d+)$/) do |amount|
  @database.insert_transaction(amount)
end

Then(/^I should see (\d+) outstanding transactions?$/) do |count|
  visit(TransactionPage).count.should == count.to_i
end

When(/^I assign the transaction to "(.*?)"$/) do |category|
  visit(TransactionPage).assign_first_transaction_to category
end

When(/^I split the transaction$/) do |table|
  visit(TransactionPage).split_first_transaction 
  table.rows.each do |category, amount|
    on(SplitTransactionPage).assign(category, amount)
  end
end
