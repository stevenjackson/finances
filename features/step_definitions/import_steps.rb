Given /^there is a file to be imported$/ do
  @database.insert_account('checking', 0)
  @transactions_file.write 'checking'
end

Then /^I will see transactions$/ do
  visit(TransactionPage).unsorted_count.should > 0
end
