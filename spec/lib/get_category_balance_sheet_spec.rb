require 'spec_helper'

describe GetCategoryBalanceSheet do

  let(:gateway) { double 'gateway' }
  let(:action) { GetCategoryBalanceSheet.new(gateway) }
  let(:debit) { Debit.new category: 'stuff', amount: 30  }
  let(:credit) { Credit.new category: 'stuff', amount: 100 }

  before(:each) do
    gateway.stub(:categories) { [Category.new('stuff', 100)] }
    gateway.stub(:debits) { [debit]  }
    gateway.stub(:credits) { [credit] }
  end

  it "provides balances for the current month by default" do
    debit.applied_on = this_month
    credit.applied_on = this_month
    sheet = action.run
    sheet.first[:category].should == 'stuff'
    sheet.first[:spent].should == 30
    sheet.first[:budget].should == 100
    sheet.first[:remainder].should == 70
  end

  it "provides balances for a month in the current year" do
    debit.applied_on = jan_this_year
    gateway.stub(:credits) {[]} 
    sheet = action.run({ month: 1 })
    sheet.first[:spent].should == 30
  end
  
  it "provides balances for a month in the current year using month abbreviation" do
    debit.applied_on = jan_this_year
    gateway.stub(:credits) {[]} 
    sheet = action.run({ month: 'Jan' })
    sheet.first[:spent].should == 30
  end

  it "provides balances for a month in the current year using month name" do
    debit.applied_on = jan_this_year
    gateway.stub(:credits) {[]} 
    sheet = action.run({ month: 'January' })
    sheet.first[:spent].should == 30
  end

  it "provides balances for a month in a past year" do
    debit.applied_on = jan_last_year
    gateway.stub(:credits) {[]} 
    sheet = action.run({ month: 1, year: Date.today.year - 1})
    sheet.first[:spent].should == 30
  end

  it "ignores debits from other months" do
    debit.applied_on = last_month
    gateway.stub(:credits) {[]} 
    sheet = action.run
    sheet.first[:spent].should == 0
  end

  it "ignores credits from other months" do
    credit.applied_on = last_month
    gateway.stub(:debits) { [] }
    sheet = action.run
    sheet.first[:remainder].should == 0
  end

  it "accomodates past month carryover" do

  end

  it "doesn't show categories that are no longer active" do

  end
end
