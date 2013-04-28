require 'spec_helper'

describe SplitTransaction do
  let(:gateway) { double("Gateway") }
  let(:action) { SplitTransaction.new gateway }

  it "splits transactions" do
    args = { 
      transaction_id: 1,
      debits: [
        {category: "cat1", amount: 5},
        {category: "cat2", amount: 7}
      ]
    }
    gateway.should_receive(:save).twice
    action.run args
  end

  it "sends debits to the gateway" do
    args = { 
      transaction_id: 1,
      debits: [
        {category: "cat1", amount: 5},
      ]
    }
    gateway.should_receive(:save) do |arg|
      arg.transaction_id.should == 1
      arg.category.should == 'cat1'
      arg.amount.should == 5
    end

    action.run args
  end
end
