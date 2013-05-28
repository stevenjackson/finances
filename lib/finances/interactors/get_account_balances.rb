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

    credit_total = transactions.select(&:credit?).map(&:amount).reduce(0, :+)
    debit_total = transactions.select(&:debit?).map(&:amount).reduce(0, :+)
    account.balance - debit_total + credit_total
  end
end
