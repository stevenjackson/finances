class Finances::SplitTransaction
  include Finances
  def initialize(gateway)
    @gateway = gateway
  end

  def run(params)
    debits = params[:debits].map do |debit|
      Debit.new(transaction_id:  params[:transaction_id], category: debit[:category], amount: debit[:amount])
    end
    debits.each { |debit| @gateway.save(debit) }
  end

end
