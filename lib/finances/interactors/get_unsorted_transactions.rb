class Finances::GetUnsortedTransactions
  def initialize(gateway)
    @gateway = gateway
  end

  def run
    sorted_transactions = @gateway.debits.map do |debit|
      @gateway.transaction_by_id debit.transaction_id
    end
    unsorted_transactions = @gateway.transactions.reject do |t|
      sorted_transactions.include? t
    end
    unsorted_transactions.map { |t| t.to_h }
  end
end
