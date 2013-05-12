require 'spec_helper'
describe GetBalanceSheetTotals do

  let(:gateway) { double 'gateway' }
  let(:action) { GetBalanceSheetTotals.new gateway }
  let(:debits) { [] }
  let(:credits) { [] }

  before(:each) do
    gateway.stub(:debits) { debits }
    gateway.stub(:credits) { credits }
  end

  it "Totals up debits for the month" do
    debits << Debit.new(amount: 200, date_applied: this_month)
    debits << Debit.new(amount: 150, date_applied: this_month)
    action.run[:debits].should == 350
  end

  it "Totals up credits for the month" do
    credits << Credit.new(amount: 70, date_applied: this_month)
    credits << Credit.new(amount: 80, date_applied: this_month)
    action.run[:credits].should == 150
  end
end
