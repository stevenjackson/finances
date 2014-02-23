require 'spec_helper'

describe GetUnsortedIncome do
  let(:gateway) { double("Gateway") }
  let(:t1) { Transaction.new(id: 1, amount: 100) }
  let(:t2) { Transaction.new(id: 2, amount: 10) }
  let(:action) { GetUnsortedIncome.new gateway  }
  let(:transactions) { [t1, t2] }
  let(:credits) { [] }

  before(:each) do
    gateway.stub(:transactions) { transactions }
    gateway.stub(:credits) { credits }
  end

  it "retrieves transactions" do
    action.run.should == [t1.to_h, t2.to_h]
  end

  it "ignores debits" do
    debit = Transaction.new(id: 3, amount: -200)
    gateway.stub(:transactions) { transactions << debit }
    action.run.should == [t1.to_h, t2.to_h]
  end

  it "filters assigned transactions" do
    gateway.stub(:credits) { [Credit.new(transaction_id: t2.id, category: 'stuff', amount: 10)] }
    action.run.should == [t1.to_h]
  end
end
