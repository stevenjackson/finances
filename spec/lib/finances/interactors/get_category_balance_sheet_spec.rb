require 'spec_helper'

describe GetCategoryBalanceSheet do

  let(:gateway) { double 'gateway' }
  let(:action) { GetCategoryBalanceSheet.new(gateway) }
  let(:debit) { Debit.new category: 'stuff', amount: 30  }
  let(:credit) { Credit.new category: 'stuff', amount: 100 }

  before(:each) do
    gateway.stub(:categories) { [Category.new(name: 'stuff', budget: 100)] }
    gateway.stub(:debits) { [debit]  }
    gateway.stub(:credits) { [credit] }
  end

  it "provides balances for the current month by default" do
    debit.date_applied = this_month
    credit.date_applied = this_month
    sheet = action.run
    sheet.first[:category].should == 'stuff'
    sheet.first[:spent].should == 30
    sheet.first[:budget].should == 100
    sheet.first[:remainder].should == 70
  end

  it "provides balances for a month in the current year" do
    debit.date_applied = jan_this_year
    gateway.stub(:credits) {[]} 
    sheet = action.run({ month: 1 })
    sheet.first[:spent].should == 30
  end

  it "provides balances for a month in the current year using month abbreviation" do
    debit.date_applied = jan_this_year
    gateway.stub(:credits) {[]} 
    sheet = action.run({ month: 'Jan' })
    sheet.first[:spent].should == 30
  end

  it "provides balances for a month in the current year using month name" do
    debit.date_applied = jan_this_year
    gateway.stub(:credits) {[]} 
    sheet = action.run({ month: 'January' })
    sheet.first[:spent].should == 30
  end

  it "provides balances for a month in a past year" do
    debit.date_applied = jan_last_year
    gateway.stub(:credits) {[]} 
    sheet = action.run({ month: 1, year: Date.today.year - 1})
    sheet.first[:spent].should == 30
  end

  it "ignores debits from other months" do
    debit.date_applied = last_month
    gateway.stub(:credits) {[]} 
    sheet = action.run
    sheet.first[:spent].should == 0
  end

  it "ignores credits from other months" do
    credit.date_applied = last_month
    gateway.stub(:debits) { [] }
    sheet = action.run
    sheet.first[:remainder].should == 0
  end

end
