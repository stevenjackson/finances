class Finances::CreateAccount
  include Finances
  def initialize(gateway)
    @gateway = gateway
  end

  def run(params)
    puts params
    return if @gateway.accounts.any? { |account| account.name == params[:name] }
    @gateway.save Account.new params
    @gateway.accounts.each { |acct| puts acct }
  end
end
