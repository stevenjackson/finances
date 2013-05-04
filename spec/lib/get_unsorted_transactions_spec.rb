require 'spec_helper'

describe GetUnsortedTransactions do
  let(:gateway) { double("Gateway") }
  let(:t1) { Transaction.new(id: 1, amount: 100) }
  let(:t2) { Transaction.new(id: 2, amount: 10) }
  let(:action) { GetUnsortedTransactions.new gateway  }

  before(:each) do
    gateway.stub(:transactions) { [t1, t2] }
  end

  it "retrieves transactions" do
    gateway.stub(:debits) { [] }
    action.run.should == [t1.to_h, t2.to_h]
  end

  it "filters assigned transactions" do
    gateway.stub(:debits) { [Debit.new(t2.id, 'stuff', 10)] }
    action.run.should == [t1.to_h]
  end

end
