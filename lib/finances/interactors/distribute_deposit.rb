class Finances::DistributeDeposit
  include Finances
  include TransactionDate
  def initialize(gateway)
    @gateway = gateway
  end

  def run(params)
    date_applied = params[:date_applied] || transaction_date(params).to_date.next_month.to_time 
    credits = params[:credits].map do |credit|
      Credit.new transaction_id: params[:transaction_id], category: credit[:category], amount: credit[:amount], date_applied: date_applied
    end

    stored_credits = @gateway.credits.select { |credit| credit.transaction_id == params[:transaction_id] }

    to_delete = stored_credits.reject { |credit| credits.include? credit }
    to_save = credits.reject { |credit| stored_credits.include? credit }

    to_delete.each { |credit| @gateway.delete(credit) }
    to_save.each { |credit| @gateway.save(credit) }
  end

end
