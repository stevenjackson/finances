require 'spec_helper'

describe GetCategoryBalanceSheet do

  let(:gateway) { double 'gateway' }
  let(:action) { GetCategoryBalanceSheet.new(gateway) }
  
  before(:each) do
    gateway.stub(:categories) { [Category.new('stuff', 100)] }
  end

  it "provides balances for the current month by default" do
    gateway.stub(:debits) { [Debit.new(category: 'stuff', amount: 30, applied_on: this_month)]  }
    gateway.stub(:credits) { [Credit.new(category: 'stuff', amount: 100, applied_on: this_month)]   }
    sheet = action.run
    sheet.first[:category].should == 'stuff'
    sheet.first[:spent].should == 30
    sheet.first[:budget].should == 100
    sheet.first[:remainder].should == 70
  end

  it "provides balances for a month in the current year" do

  end
  
  it "provides balances for a month in a past year" do
  end

  it "ignores deposits from other months" do

  end

  it "ignores credits from other months" do

  end

  it "accomodates past month carryover" do

  end

  it "doesn't show categories that are no longer active" do

  end
end
