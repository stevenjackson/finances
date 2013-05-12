require 'spec_helper'

describe AssignTransaction do
  let(:gateway) { double("Gateway") }
  let(:action) { AssignTransaction.new gateway  }
  let(:transaction_date) { Date.today.prev_month.to_time }
  let(:transaction) { Transaction.new posted_at: transaction_date }

  before(:each) do
    gateway.stub(:transaction_by_id) { transaction }
  end


  it "saves debits" do
    gateway.should_receive(:save).with(kind_of(Debit))
    action.run transaction_id: 1, category: "abc", amount: 123
  end

  it "applies to the transaction date by default" do
    gateway.should_receive(:save) do |debit|
      debit.date_applied.should == transaction_date
    end
    action.run transaction_id: 1, category: "abc", amount: 123
  end

  it "can be applied to other months" do
    gateway.should_receive(:save) do |debit|
      debit.date_applied.should == jan_this_year
    end
    action.run transaction_id: 1, category: "abc", amount: 123, date_applied: jan_this_year
  end

end


