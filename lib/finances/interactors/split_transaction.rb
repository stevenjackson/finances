class Finances::SplitTransaction
  include Finances
  def initialize(gateway)
    @gateway = gateway
  end

  def run(params)
    debits = params[:debits].map do |debit|
      Debit.new params[:transaction_id], debit[:category], debit[:amount]
    end
    debits.each { |debit| @gateway.save(debit) }
  end

end
