class Finances::Account
  include Finances::HashTranslator

  attr_accessor :id, :name, :balance

end
