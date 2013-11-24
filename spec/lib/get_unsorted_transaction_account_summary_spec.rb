require 'spec_helper'

describe GetUnsortedTransactionAccountSummary do
  let(:gateway) { double("Gateway") }
  let(:t1) { Transaction.new(id: 1, amount: 100) }
  let(:t2) { Transaction.new(id: 2, amount: 10) }
  let(:t3) { Transaction.new(id: 3, amount: 25) }
  let(:checking) { Account.new(id: 42, name: 'checking') }
  let(:savings) { Account.new(id: 43, name: 'savings') }
  let(:action) { GetUnsortedTransactionAccountSummary.new gateway }

  before(:each) do
    gateway.stub(:transactions) { [t1, t2, t3] }
    gateway.stub(:debits) { [Debit.new(transaction_id: t2.id, category: 'stuff', amount: 10)] }
    gateway.stub(:accounts) { [checking, savings] }
  end

  it "should contain an unsorted transaction count for an account" do
    t1.account_id = checking.id
    action.run[:checking][:count].should == 1
  end

  it "should total the unsorted transactions" do
    t1.account_id = checking.id
    t2.account_id = checking.id
    t3.account_id = checking.id
    action.run[:checking][:count].should == 2
    action.run[:checking][:amount].should == 125
  end

  it "does not contain accounts that do not have unsorted transactions" do
    action.run[:savings].should be_nil
  end
end
