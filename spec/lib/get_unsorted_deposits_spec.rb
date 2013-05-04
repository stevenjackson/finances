require 'spec_helper'

describe GetUnsortedDeposits do
  let(:gateway) { double("Gateway") }
  let(:deposit) { Transaction.new(id: 1, amount: 100, type: :credit) }
  let(:expense) { Transaction.new(id: 2, amount: -10) }
  let(:action) { GetUnsortedDeposits.new gateway  }

  before(:each) do
    gateway.stub(:transactions) { [deposit, expense] }
  end

  it "retrieves deposits ignoring expenses" do
    action.run.should == [deposit.to_h]
  end
end
