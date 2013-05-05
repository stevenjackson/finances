class Finances::GetAccountBalances
  def initialize(gateway)
    @gateway = gateway
  end

  def run
    balances = {}
    @gateway.accounts.each do |account|
      balances[account.name.to_sym] = balance account
    end
    balances
  end

  def balance(account)
    transactions = @gateway.transactions.select { |t| account.id == t.account_id }
    credit_total = transactions.select{ |t| t.type == :credit }.reduce(0){ |sum, t| sum + t.amount}
    debit_total = transactions.select{ |t| t.type == :debit }.reduce(0){ |sum, t| sum + t.amount}
    account.balance - debit_total + credit_total
  end
end
