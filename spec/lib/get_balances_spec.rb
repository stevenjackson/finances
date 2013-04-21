require 'spec_helper'

describe GetBalances do
  let(:gateway) { TestGateway.new }
  let(:action) { GetBalances.new gateway  }

  it "calculates category balances" do
    action.run[:stuff].should be 90
  end


end

class TestGateway
  def categories
    [Category.new('stuff', 100)]
  end

  def debits
    [Debit.new(1, 'stuff', 10)]
  end
end
