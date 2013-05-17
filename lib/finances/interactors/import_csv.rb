require 'csv'
require 'date'

class Finances::ImportCsv
  def initialize(gateway)
    @gateway = gateway
  end

  def run(params)
    @file_path = params[:file]
    @account_id = params[:account_id]
    @transactions = []
    csv = CSV.foreach(@file_path) { |line| read_line line }
    save
  end

  def read_line(line)
    date = parse_date line[0]
    description = line[1]
    amount = parse_amount line[2]

    add_transaction date, description, amount
  end

  def parse_date(value)
    begin
      Date.strptime(value, "%m/%d/%Y").to_time
    rescue
    end
  end

  def parse_amount(value)
    return unless value
    match = value.match /(-?)(\d+)\.(\d+)/
    if match
      "#{match[1]}#{match[2]}#{match[3]}".to_i
    end
  end

  def add_transaction(date, description, amount_in_pennies)
    return unless date and description and amount_in_pennies

    amount = (amount_in_pennies / 100).round

    transactions << Transaction.new(account_id: @account_id, posted_at: date, description: description, amount: amount, amount_in_pennies: amount_in_pennies)
  end

  def save
    account_transactions = @gateway.transactions_by_account_id(@account_id)
    unknown_transactions = transactions.reject do |t|
     account_transactions.include? t
    end
    unknown_transactions.each { |t| @gateway.save t }
  end

  def file_loaded?
    not @file_path.nil?
  end

  def transactions
    @transactions ||= []
  end
end
