class Finances::GetUnsortedIncome
  include Finances::GroupByAccount

  def initialize(gateway)
    @gateway = gateway
  end

  def run
    group_by_account unsorted_transactions
  end

  def unsorted_transactions
    sorted_transaction_ids = @gateway.credits.map(&:transaction_id)
    @gateway.transactions.select(&:credit?).reject do |t|
      sorted_transaction_ids.include? t.id
    end
  end
end
