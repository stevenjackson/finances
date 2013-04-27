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
end
