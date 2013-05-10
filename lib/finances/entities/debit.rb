class Finances::Debit
  include Finances::HashTranslator
  include Finances::Bookkeeping
  attr_accessor :transaction_id, :category, :amount, :applied_on
end
