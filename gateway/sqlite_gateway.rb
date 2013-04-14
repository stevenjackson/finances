require 'sequel'
class SqliteGateway
  include Finances

  def initialize(url)
    @db = Sequel.connect(url)
  end

  def categories
    [Category.new('groc', 40)]
  end

  def debits
    []
  end
end
