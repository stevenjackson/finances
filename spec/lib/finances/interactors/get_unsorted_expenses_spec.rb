require 'spec_helper'

describe GetUnsortedExpenses do
  let(:gateway) { double("Gateway") }
  let(:account) { Account.new id: 216, name: 'fun' }
  let(:t1) { Transaction.new(id: 1, account_id: account.id, amount: -100) }
  let(:t2) { Transaction.new(id: 2, account_id: account.id, amount: -10) }
  let(:action) { GetUnsortedExpenses.new gateway  }
  let(:transactions) { [t1, t2] }
  let(:debits) { [] }

  before(:each) do
    gateway.stub(:transactions) { transactions }
    gateway.stub(:debits) { debits }
    gateway.stub(:accounts) { [account] }
  end

  it "retrieves transactions" do
    action.run.should == { account.to_h => [t1.to_h, t2.to_h] }
  end

  it "ignores credits" do
    credit = Transaction.new(id: 3, amount: 200)
    gateway.stub(:transactions) { transactions << credit }
    action.run.should == { account.to_h => [t1.to_h, t2.to_h] }
  end

  it "filters assigned transactions" do
    gateway.stub(:debits) { [Debit.new(transaction_id: t2.id, category: 'stuff', amount: 10)] }
    action.run.should == { account.to_h => [t1.to_h] }
  end

end
