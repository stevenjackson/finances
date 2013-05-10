class Finances::Transaction
  include Finances::HashTranslator

  attr_accessor :id, :description, :amount, :account_id, :fit_id, :amount_in_pennies, :nick_name, :posted_at, :type

  def amount=(val)
    if val < 0
      val *= -1
      type = :debit
    else
      type = :credit
    end
    @amount = val
    self.type = type
  end

  def type=(val)
    @type = val.to_sym unless val.nil?
  end

  def credit?
    self.type == :credit
  end
end
