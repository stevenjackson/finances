Given /^I have a "(.*?)" account with a balance of \$(\d+)$/ do |account, balance|
  @database.insert_account(account, balance)
end

When /^I spend \$(\d+) from "(.*?)"$/ do |amount, account|
  @database.debit_account(account, amount)
end
