class Finances::GetUnsortedExpenses
  include Finances::GroupByAccount

  def initialize(gateway)
    @gateway = gateway
  end

  def run
    group_by_account unsorted_transactions
  end

  def unsorted_transactions
    sorted_transaction_ids = @gateway.debits.map(&:transaction_id)
    @gateway.transactions.select(&:debit?).reject do |t|
      sorted_transaction_ids.include? t.id
    end
  end
end
