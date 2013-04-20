class Finances::GetUnsortedTransactions
  def initialize(gateway)
    @gateway = gateway
  end

  def run
    @unsorted_transactions = [
      {:id => 1, :description => 'Transaction1', :amount => '35' },
      {:id => 2, :description => 'Transaction2', :amount => '50' }
    ]
  end
end
