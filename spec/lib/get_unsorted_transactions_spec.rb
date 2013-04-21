require 'spec_helper'

describe GetUnsortedTransactions do
  let(:gateway) { TestGateway.new }
  let(:action) { GetUnsortedTransactions.new gateway  }

  it "retrieves transactions" do
    action.run.one? { |t| t[:id] == 1 }.should be_true
  end


end

class TestGateway
  def transactions
    t1 = Transaction.new(1, 'desc', 100)
    [t1]
  end

  def debits
    [Debit.new('stuff', 10)]
  end
end
