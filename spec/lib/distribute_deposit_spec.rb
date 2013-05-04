require 'spec_helper'

describe DistributeDeposit do
  let(:gateway) { double('gateway') }
  let(:action) { DistributeDeposit.new(gateway) }

  before(:each) do
    gateway.stub(:credits) { [] }
  end

  it "credits categories" do
    args = { 
      transaction_id: 1,
      credits: [
        {category: "cat1", amount: 5},
        {category: "cat2", amount: 7}
      ]
    }
    gateway.should_receive(:save).twice
    action.run args
  end

  it "removes credits if needed" do
    gateway.stub(:credits) { [Credit.new(1, "old_cat", 10)] }
    gateway.should_receive(:delete)
    action.run transaction_id: 1, credits: []
  end

  it "updates credits if needed" do
    gateway.stub(:credits) { [Credit.new(1, "cat1", 10)] }
    gateway.should_receive(:delete)
    gateway.should_receive(:save)
    action.run transaction_id: 1, credits: [ {category: "cat1", amount: 5} ]
  end

  it "does not updates credits when not needed" do
    gateway.stub(:credits) { [Credit.new(1, "cat1", 5)] }
    gateway.should_not_receive(:delete)
    gateway.should_not_receive(:save)
    action.run transaction_id: 1, credits: [ {category: "cat1", amount: 5} ]
  end
end
