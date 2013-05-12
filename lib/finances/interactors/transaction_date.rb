module Finances::TransactionDate
  def transaction_date(params)
    @gateway.transaction_by_id(params[:transaction_id]).posted_at
  end
end
