class Finances::GetUnsortedTransactions
  def initialize(gateway)
    @gateway = gateway
  end

  def run
    sorted_transaction_ids = @gateway.debits.map(&:transaction_id)
    unsorted_transactions = @gateway.transactions.reject do |t|
      sorted_transaction_ids.include? t.id
    end
    unsorted_transactions.map(&:to_h)
  end
end
