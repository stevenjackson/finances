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

  def transactions
    @db[:transactions].map { |r| to_transaction r }
  end

  def transaction_by_id(id)
    to_transaction @db[:transactions][:id => id]
  end

  def save(debit)
    @db[:debits].insert :transaction_id => debit.transaction_id, :category => debit.category, :amount => debit.amount
  end

  def account_by_name(name)
    @db[:accounts][:name => name]
    Account.new r[:id], r[:name], r[:balance]
  end

  private
  def to_transaction(r)
    return if r.nil?

    Transaction.new id: r[:id],
      description: r[:description],
      amount: r[:amount]
  end
end
