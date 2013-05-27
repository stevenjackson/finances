class Finances::GetCredits
  def initialize(gateway)
    @gateway = gateway
  end

  def run(params)
    @gateway.credits.select {|c| c.transaction_id == params[:transaction_id] }.map(&:to_h)
  end
end
