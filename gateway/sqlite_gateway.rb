require 'sequel'
class SqliteGateway
  include Finances

  def initialize(url)
    @db = Sequel.connect(url)
  end

  def categories
    load_objects @db[:categories], Category
  end

  def debits
    load_objects @db[:debits], Debit
  end

  def credits
    load_objects @db[:credits], Credit
  end

  def accounts
    load_objects @db[:accounts], Account
  end

  def transactions
    load_objects @db[:transactions], Transaction
  end

  def transaction_by_id(id)
    to_object @db[:transactions][:id => id], Transaction
  end

  def save(o)
    case o
    when Debit
      save_debit o
    when Transaction
      save_transaction o
    when Credit
      save_credit o
    when Account
      save_account o
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

  def save_account(account)
    @db[:accounts].insert :name => account.name, :balance => account.balance
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
    to_object @db[:accounts][:name => name], Account
  end

  def transactions_by_account_id(account_id)
    load_objects @db[:transactions].filter(:account_id => account_id), Transaction
  end

  def account_balances(account)
    @db[:account_balances].filter(:account_id => account.id).map do |r|
      AccountBalance.new account: account, balance: r[:balance], date: r[:date]
    end

  end

  private
  def load_objects(enum, clazz)
    enum.map { |r| to_object r, clazz }
  end

  def to_object(r, clazz)
    return if r.nil?

    clazz.new r.to_h.keep_if { |key, value| clazz.method_defined? key }
  end
end
