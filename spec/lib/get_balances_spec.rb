require 'spec_helper'

describe GetBalances do
  let(:gateway) { double("Gateway") }
  let(:action) { GetBalances.new gateway  }

  before(:each) do
    gateway.stub(:categories) { [Category.new('stuff', 100)] }
    gateway.stub(:debits) { [] }
    gateway.stub(:credits) { [] }
  end

  it "subtract debits from category balances" do
    gateway.stub(:debits) { [Debit.new(1, 'stuff', 10)] }

    action.run[:stuff].should be 90
  end

  it "adds credits to category balances" do
    gateway.stub(:credits) { [Credit.new(1, 'stuff', 10)] }

    action.run[:stuff].should be 110
  end

end
