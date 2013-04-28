require 'spec_helper'

describe GetBalances do
  let(:gateway) { double("Gateway") }
  let(:action) { GetBalances.new gateway  }

  it "calculates category balances" do
    gateway.stub(:categories) { [Category.new('stuff', 100)] }
    gateway.stub(:debits) { [Debit.new(1, 'stuff', 10)] }

    action.run[:stuff].should be 90
  end

end
