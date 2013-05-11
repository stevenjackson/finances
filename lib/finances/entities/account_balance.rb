class Finances::AccountBalance
  include Finances::HashTranslator
  attr_accessor :account, :balance, :date
end
