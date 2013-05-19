require 'sequel'
class SqliteGateway
  include Finances

  def initialize(url)
    @db = Sequel.connect(url)
  end

  def categories
    @db[:categories].map do |r|
      Category.new r[:name], r[:budget]
    end
  end

  def debits
    @db[:debits].map do |r|
      Debit.new r.to_h.keep_if { |key, value| Debit.method_defined? key }
    end
  end

  def credits
    @db[:credits].map do |r|
      Credit.new r.to_h.keep_if { |key, value| Credit.method_defined? key }
    end
  end

  def accounts
    @db[:accounts].map do |r|
      Account.new r[:id], r[:name], r[:balance]
    end
  end

  def transactions
    @db[:transactions].map { |r| to_transaction r }
  end

  def transaction_by_id(id)
    to_transaction @db[:transactions][:id => id]
  end

  def save(o)
    case o
    when Debit
      save_debit o
    when Transaction
      save_transaction o
    when Credit
      save_credit o
    end
  end

  def save_debit(debit)
    @db[:debits].insert :transaction_id => debit.transaction_id, :category => debit.category, :amount => debit.amount, :date_applied => debit.date_applied
  end

  def save_transaction(transaction)
    @db[:transactions].insert :account_id => transaction.account_id, :fit_id => transaction.fit_id, :description => transaction.description, :amount => transaction.amount, :amount_in_pennies => transaction.amount_in_pennies, :nick_name => transaction.nick_name, :posted_at => transaction.posted_at, :type => transaction.type.to_s
  end

  def save_credit(credit)
    @db[:credits].insert :transaction_id => credit.transaction_id, :category => credit.category, :amount => credit.amount, :date_applied => credit.date_applied
  end

  def delete(o)
    case o
    when Credit
      delete_credit o
    end
  end

  def delete_credit(credit)
      @db[:credits].where(:transaction_id => credit.transaction_id, :category => credit.category, :amount => credit.amount).delete
  end

  def account_by_name(name)
    r = @db[:accounts][:name => name]
    Account.new r[:id], r[:name], r[:balance]
  end

  def transactions_by_account_id(account_id)
    @db[:transactions].filter(:account_id => account_id).map { |r| to_transaction r }
  end

  def account_balances(account)
    @db[:account_balances].filter(:account_id => account.id).map do |r|
      AccountBalance.new account: account, balance: r[:balance], date: r[:date]
    end

  end

  private
  def to_transaction(r)
    return if r.nil?

    Transaction.new r.to_h 
  end
end
