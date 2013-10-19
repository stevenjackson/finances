class Finances::Category
  include Finances::HashTranslator

  attr_accessor :name, :budget

end
