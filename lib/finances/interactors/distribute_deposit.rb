class Finances::DistributeDeposit
  include Finances
  def initialize(gateway)
    @gateway = gateway
  end

  def run(params)
    credits = params[:credits].map do |credit|
      Credit.new params[:transaction_id], credit[:category], credit[:amount]
    end

    stored_credits = @gateway.credits.select { |credit| credit.transaction_id == params[:transaction_id] }
    
    to_delete = stored_credits.reject { |credit| credits.include? credit }
    to_save = credits.reject { |credit| stored_credits.include? credit }

    to_delete.each { |credit| @gateway.delete(credit) }
    to_save.each { |credit| @gateway.save(credit) }
  end

end
