require 'spec_helper'

describe GetExpenseBalanceSheet do
  let(:gateway) { double 'gateway' }
  let(:action) { GetExpenseBalanceSheet.new(gateway) }
  let(:debit) { Debit.new category: 'stuff', amount: 30, date_applied: this_month }
  let(:transaction) { Transaction.new :description => 'Someplace' }

  before(:each) do
    gateway.stub(:debits) { [debit] }
    gateway.stub(:transaction_by_id) { transaction }
  end
  it "provides expenses for the current month by default" do
    sheet = action.run
    sheet.first[:amount].should == 30
    sheet.first[:description].should == 'Someplace'
    sheet.first[:category].should == 'stuff'
  end

  it 'defaults to Unknown for the description if there is no transaction' do
    gateway.stub(:transaction_by_id) {nil}
    sheet = action.run
    sheet.first[:description].should == 'Unknown'
  end

  it 'formats the date nicely' do
    debit.date_applied = DateTime.new(2009, 9, 2, 12).to_time
    sheet = action.run({ month: 9, year: 2009 })
    sheet.first[:date].should == 'Sep-2'
  end
end
