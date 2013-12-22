require 'spec_helper'

describe SplitTransaction do
  let(:gateway) { double("Gateway") }
  let(:action) { SplitTransaction.new gateway }
  let(:transaction_date) { Date.today.prev_month.to_time }
  let(:transaction) { Transaction.new posted_at: transaction_date }

  before(:each) do
    gateway.stub(:transaction_by_id) { transaction }
  end

  it "splits transactions" do
    args = { 
      transaction_id: 1,
      debits: [
        {category: "cat1", amount: 5},
        {category: "cat2", amount: 7}
      ]
    }
    gateway.should_receive(:save).twice
    action.run args
  end

  it "sends debits to the gateway" do
    args = { 
      transaction_id: 1,
      debits: [
        {category: "cat1", amount: 5},
      ]
    }
    gateway.should_receive(:save) do |arg|
      arg.transaction_id.should == 1
      arg.category.should == 'cat1'
      arg.amount.should == 5
    end

    action.run args
  end

  it "applies debits to the posted month by default" do
    gateway.should_receive(:save) do |debit|
      debit.date_applied.should == transaction_date
    end

    action.run transaction_id: 1, debits: [{ category: "cat1", amount: 5}]
  end

  it "can apply debits to other months" do

    gateway.should_receive(:save) do |debit|
      debit.date_applied.should == jan_this_year
    end
    action.run transaction_id: 1, date_applied: jan_this_year, debits: [{ category: "cat1", amount: 5}]
  end
end
