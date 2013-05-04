class Finances::GetUnsortedDeposits
  def initialize(gateway)
    @gateway = gateway
  end

  def run
    @gateway.transactions.select{|t| t.credit? }.map {|t| t.to_h }
  end
end
