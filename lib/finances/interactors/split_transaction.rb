class Finances::SplitTransaction
  include Finances
  include TransactionDate

  def initialize(gateway)
    @gateway = gateway
  end

  def run(params)
    params[:date_applied] ||= transaction_date params
    debits = params[:debits].map do |debit|
      Debit.new(transaction_id:  params[:transaction_id], date_applied: params[:date_applied], category: debit[:category], amount: debit[:amount])
    end
    debits.each { |debit| @gateway.save(debit) }
  end

end
