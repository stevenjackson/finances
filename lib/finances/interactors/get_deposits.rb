class Finances::GetDeposits
  def initialize(gateway)
    @gateway = gateway
  end

  def run
    @gateway.transactions.select(&:credit?).map(&:to_h)
  end
end
