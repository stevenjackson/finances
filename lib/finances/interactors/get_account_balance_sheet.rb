class Finances::GetAccountBalanceSheet
  include Finances::DateParams
  def initialize(gateway)
    @gateway = gateway
  end

  def run(params={})
    @month, @year = parse_date params
    accounts.map do |a|
    {
        account:  a.name,
        starting: starting(a),
        change:   transaction_total(a)
    }
    end.each do |h|
      h[:ending] = h[:starting] + h[:change]
    end 
  end

  def accounts
    @gateway.accounts
  end

  def starting(account)
    first_of_month = Date.new @year, @month, 1
    find_latest_balance_before(account, first_of_month).balance
  end

  def find_latest_balance_before(account, max_date)
    @gateway.account_balances(account).reduce do |last_month, balance|
      if(balance.date < max_date and balance.date > last_month)
        balance.date
      else
        last_month
      end
    end
  end

  def transaction_total(account)
    month_transactions(account).reduce(0) do |sum, transaction|
      if(transaction.credit?)
        sum += transaction.amount
      else
        sum -= transaction.amount
      end
    end
  end

  def month_transactions(account)
    @gateway.transactions_by_account_id(account.id).select do |transaction|
      transaction_date = transaction.posted_at.to_date
      transaction_date.month == @month and transaction_date.year == @year
    end
  end

end
