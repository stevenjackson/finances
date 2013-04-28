require 'ofx'

class Finances::ImportOfx
  def initialize(gateway)
    @gateway = gateway
  end

  def run(params)
    @file_path = @gateway.file_path params[:file]
    @transactions = []
    ofx = OFX(@file_path)
    ofx.account.transactions.each do |t|
      @transactions << to_transaction(t)
    end
    @transactions
  end

  def file_loaded?
    not @file_path.nil?
  end

  def transactions
    @transactions || []
  end

  private
  def to_transaction(t)
    Transaction.new(nil, t.memo, t.amount.round)
  end
end
