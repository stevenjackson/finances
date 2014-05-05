class Finances::GetTransaction
  def initialize(gateway)
    @gateway = gateway
  end

  def run(params)
    @gateway.transaction_by_id(params[:id]).to_h
  end
end
