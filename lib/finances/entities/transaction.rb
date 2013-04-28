class Finances::Transaction
  attr_accessor :id, :description, :amount, :account_id, :fit_id, :amount_in_pennies, :nick_name, :posted_at, :type

  def initialize(opts)
    opts.each_pair do |key, value|
      send("#{key}=",value)
    end
  end

  def to_h
    instance_variables.reduce({}) do |hash, var|
      hash[var[1..-1].to_sym] = instance_variable_get(var)
      hash
    end
  end
end
