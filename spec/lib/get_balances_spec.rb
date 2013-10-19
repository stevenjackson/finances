require 'spec_helper'

describe GetCategoryBalances do
  let(:gateway) { double("Gateway") }
  let(:action) { GetCategoryBalances.new gateway  }

  before(:each) do
    gateway.stub(:categories) { [Category.new(name: 'stuff', budget: 100)] }
    gateway.stub(:debits) { [] }
    gateway.stub(:credits) { [] }
  end

  it "subtract debits from category balances" do
    gateway.stub(:debits) { [Debit.new(transaction_id: 1, category: 'stuff', amount: 10)] }

    action.run[:stuff].should be 90
  end

  it "adds credits to category balances" do
    gateway.stub(:credits) { [Credit.new(transaction_id: 1, category: 'stuff', amount: 10)] }

    action.run[:stuff].should be 110
  end

end
