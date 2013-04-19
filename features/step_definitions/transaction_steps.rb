Given(/^I have a transaction for \$(\d+)$/) do |amount|
  @database.insert_transaction(amount)
end

Then(/^I should see (\d+) outstanding transactions$/) do |count|
  visit(TransactionPage).count.should == count
end

When(/^I assign the transaction to "(.*?)"$/) do |category|
  visit(TransactionPage).assign_first_transaction_to category
end

When(/^I split the transaction$/) do |table|
    # table is a Cucumber::Ast::Table
  #   pending # express the regexp above with the code you wish you had
end
