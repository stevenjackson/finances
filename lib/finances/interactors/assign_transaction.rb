class Finances::AssignTransaction
  include Finances
  include TransactionDate
  def initialize(gateway)
    @gateway = gateway
  end

  def run(params)
    params[:date_applied] ||= transaction_date params
    debit = Debit.new params.keep_if { |key, value| Debit.method_defined? key }
    @gateway.save(debit)
  end

end
