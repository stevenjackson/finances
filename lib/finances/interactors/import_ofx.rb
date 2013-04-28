require 'ofx'

class Finances::ImportOfx
  def initialize(gateway)
    @gateway = gateway
  end

  def run(params)
    @file_path = @gateway.file_path params[:file]
    @account_id = @gateway.account_by_name(:account).id
    ofx = OFX @file_path
    ofx.account.transactions.each do |t|
      transactions << to_transaction(t)
    end
    save
  end

  def file_loaded?
    not @file_path.nil?
  end

  def transactions
    @transactions ||= []
  end

  private
  def to_transaction(t)
    Transaction.new description: t.name,
                    amount: t.amount.round,
                    account_id: @account_id,
                    fit_id: t.fit_id,
                    amount_in_pennies: t.amount_in_pennies,
                    posted_at: t.posted_at,
                    type: t.type
  end

  def save
    transactions.each { |t| @gateway.save(t) }
  end
end