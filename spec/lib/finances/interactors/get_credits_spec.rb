require 'spec_helper'

describe GetCredits do
  let(:gateway) { double 'gateway' }
  let(:action) { GetCredits.new gateway }
  let(:c1) { Credit.new transaction_id: 1, category: 'stuff', amount: 10 }
  let(:c2) { Credit.new transaction_id: 2, category: 'stuff', amount: 20 }
  let(:c3) { Credit.new transaction_id: 1, category: 'things', amount: 30 }

  before(:each) do
    gateway.stub(:credits) { [c1, c2, c3] }
  end

  it "pulls credits by transaction id" do
    args = { transaction_id: 1 }
    action.run(args).should == [c1.to_h, c3.to_h]
  end

end
