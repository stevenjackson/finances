class Finances::SplitTransaction
  include Finances
  def initialize(gateway)
    @gateway = gateway
  end

  def run(params)

    #debit = Debit.new params[:transaction_id], params[:category], params[:amount]
    #@gateway.save(debit)
  end

end
