class Finances::DistributeDeposit
  include Finances
  def initialize(gateway)
    @gateway = gateway
  end

  def run(params)
    credits = params[:credits].map do |credit|
      Credit.new params[:transaction_id], credit[:category], credit[:amount]
    end
    credits.each { |credit| @gateway.save(credit) }
  end

end
