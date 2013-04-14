require 'spec_helper'

describe GetBalances do
  let(:gateway) { TestGateway.new }
  let(:action) { GetBalances.new gateway  }

  it "calculates category balances" do
    action.run[:stuff].should == 90
  end


end

class TestGateway
  def categories
    [Category.new('stuff', 100)]
  end

  def debits
    [Debit.new('stuff', 10)]
  end
end
