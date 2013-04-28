class Finances::GetUnsortedTransactions
  def initialize(gateway)
    @gateway = gateway
  end

  def run
    sorted_transaction_ids = @gateway.debits.map do |debit|
      debit.transaction_id
    end
    unsorted_transactions = @gateway.transactions.reject do |t|
      sorted_transaction_ids.include? t.id
    end
    unsorted_transactions.map { |t| t.to_h }
  end
end
