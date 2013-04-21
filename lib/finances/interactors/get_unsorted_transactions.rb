class Finances::GetUnsortedTransactions
  def initialize(gateway)
    @gateway = gateway
  end

  def run
   @gateway.transactions.map { |t| t.to_h }
  end
end
