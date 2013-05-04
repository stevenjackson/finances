require 'spec_helper'

describe DistributeDeposit do
  let(:gateway) { double('gateway') }
  let(:action) { DistributeDeposit.new(gateway) }

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

end
