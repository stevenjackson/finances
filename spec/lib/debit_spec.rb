require 'spec_helper'
describe Debit do

  it "takes a hash constructor" do
    date_applied = Time.new
    d = Debit.new amount: 100, category: 'stuff', date_applied: date_applied
    d.amount.should == 100
    d.category.should == 'stuff'
    d.date_applied.should == date_applied
  end

  it "matches on category, month, and year" do
    now = Time.new
    d = Debit.new category: 'stuff', date_applied: now
    d.should be_matches 'stuff', now.to_date.month, now.to_date.year
    d.should_not be_matches 'stuff', now.to_date.month, 1945
    d.should_not be_matches 'stuff', 13, now.to_date.year
    d.should_not be_matches 'unstuff', now.to_date.month, now.to_date.year
  end

end
