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
      Debit.new r[:transaction_id], r[:category], r[:amount]
    end
  end

  def credits
    @db[:credits].map do |r|
      Credit.new r[:transaction_id], r[:category], r[:amount]
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
    @db[:debits].insert :transaction_id => debit.transaction_id, :category => debit.category, :amount => debit.amount
  end

  def save_transaction(transaction)
    @db[:transactions].insert :account_id => transaction.account_id, :fit_id => transaction.fit_id, :description => transaction.description, :amount => transaction.amount, :amount_in_pennies => transaction.amount_in_pennies, :nick_name => transaction.nick_name, :posted_at => transaction.posted_at, :type => transaction.type.to_s
  end

  def save_credit(credit)
    @db[:credits].insert :transaction_id => credit.transaction_id, :category => credit.category, :amount => credit.amount
  end

  def account_by_name(name)
    @db[:accounts][:name => name]
    Account.new r[:id], r[:name], r[:balance]
  end

  def transactions_by_account_id(account_id)
    @db[:transactions][:account_id => account_id].map { |r| to_transaction r }
  end

  private
  def to_transaction(r)
    return if r.nil?

    Transaction.new id: r[:id],
      description: r[:description],
      amount: r[:amount]
  end
end
