class Finances::GetUnsortedIncome
  def initialize(gateway)
    @gateway = gateway
  end

  def run
    unsorted_transactions.map(&:to_h)
  end

  def unsorted_transactions
    sorted_transaction_ids = @gateway.credits.map(&:transaction_id)
    @gateway.transactions.select(&:credit?).reject do |t|
      sorted_transaction_ids.include? t.id
    end
  end
end
