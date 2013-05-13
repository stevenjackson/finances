Given /^there is a file to be imported$/ do

end

When /^I wait long enough for it to be imported$/ do

end

Then /^I will see transactions$/ do
  visit(TransactionPage).count.should > 0
end
