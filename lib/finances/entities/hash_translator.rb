module Finances::HashTranslator
  def initialize(opts={})
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

  def ==(other)
    return false unless other.respond_to? :to_h
    return to_h == other.to_h
  end

  def eql?(other)
    return self == other
  end

  def hash
    to_h.hash
  end
end
