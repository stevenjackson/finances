require 'spec_helper'

describe AssignTransaction do
  let(:gateway) { double("Gateway") }
  let(:action) { AssignTransaction.new gateway  }

  it "saves debits" do
    gateway.should_receive(:save).with(kind_of(Debit))
    action.run transaction_id: 1, category: "abc", amount: 123
  end

end


