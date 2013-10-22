class Finances::GetUnsortedTransactionAccountSummary
  def initialize(gateway)
    @gateway = gateway
  end

  def run
    unsorted_transactions = GetUnsortedTransactions.new(@gateway).unsorted_transactions
    @gateway.accounts.each_with_object({}) do |account, hash|
       hash[account.name.to_sym] = summarize(account, unsorted_transactions) 
    end
  end

  def summarize(account, unsorted_transactions)
    account_trans = unsorted_transactions.select { |trans| account.id == trans.account_id }
    total = account_trans.map(&:amount).reduce(:+)
    { count: account_trans.size, amount: total }
  end
end
