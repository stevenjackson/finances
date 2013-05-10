class Finances::AssignTransaction
  include Finances
  def initialize(gateway)
    @gateway = gateway
  end

  def run(params)
    debit = Debit.new params.keep_if { |key, value| Debit.method_defined? key }
    @gateway.save(debit)
  end

end
