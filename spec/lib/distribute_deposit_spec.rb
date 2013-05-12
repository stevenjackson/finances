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
    gateway.stub(:credits) { [Credit.new(transaction_id: 1,)] }
    gateway.should_receive(:delete)
    action.run transaction_id: 1, credits: []
  end

  it "updates credits if needed" do
    gateway.stub(:credits) { [Credit.new(transaction_id: 1, category: "cat1", amount: 10)] }
    gateway.should_receive(:delete)
    gateway.should_receive(:save)
    action.run transaction_id: 1, credits: [ {category: "cat1", amount: 5} ]
  end

  it "applies to next month by default" do
    gateway.should_receive(:save) { |credit| credit.date_applied.should == next_month }
    action.run transaction_id: 1, credits: [ {category: "cat1", amount: 5} ]
  end

  it "can be applied to different months" do
    gateway.should_receive(:save) { |credit| credit.date_applied.should == jan_this_year }
    action.run transaction_id: 1, date_applied: jan_this_year, credits: [ {category: "cat1", amount: 5} ]
  end

  it "does not update credits when not needed" do
    gateway.stub(:credits) { [Credit.new(transaction_id: 1, category: "cat1", amount: 5, date_applied: next_month )] }
    gateway.should_not_receive(:delete)
    gateway.should_not_receive(:save)
    action.run transaction_id: 1, credits: [ {category: "cat1", amount: 5} ]
  end
end
