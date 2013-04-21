require 'spec_helper'

describe GetUnsortedTransactions do
  let(:gateway) { TestGateway.new }
  let(:action) { GetUnsortedTransactions.new gateway  }

  it "retrieves transactions" do
    action.run.one? { |t| t[:id] == 1 }.should be_true
  end

  it "filters assigned transactions" do
    action.run.count.should be 1
  end

end

class TestGateway
  def transactions
    t1 = Transaction.new(1, 'desc', 100)
    t2 = Transaction.new(2, 'desc', 10)
    [t1, t2]
  end

  def transaction_by_id(id)
    transactions.find { |t| t.id == id }
  end

  def debits
    [Debit.new(2, 'stuff', 10)]
  end
end
