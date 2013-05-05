class Finances::Transaction
  attr_accessor :id, :description, :amount, :account_id, :fit_id, :amount_in_pennies, :nick_name, :posted_at, :type

  def initialize(opts={})
    opts.each_pair do |key, value|
      send("#{key}=",value)
    end
  end

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

  def to_h
    instance_variables.reduce({}) do |hash, var|
      hash[var[1..-1].to_sym] = instance_variable_get(var)
      hash
    end
  end

  def credit?
    self.type == :credit
  end
end
