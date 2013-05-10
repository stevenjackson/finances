class Finances::AssignTransaction
  include Finances
  def initialize(gateway)
    @gateway = gateway
  end

  def run(params)
    debit = Debit.new params.to_h
    @gateway.save(debit)
  end

end
