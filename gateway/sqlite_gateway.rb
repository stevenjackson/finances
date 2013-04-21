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
      Debit.new r[:category], r[:amount]
    end
  end


  def transactions
    @db[:transactions].map do |r|
      Transaction.new r[:id], r[:description], r[:amount]
    end
  end
end
