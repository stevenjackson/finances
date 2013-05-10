module Finances::Bookkeeping
  def matches?(category, month, year)
    category == self.category and self.applied_on.to_date.month == month and self.applied_on.to_date.year == year
  end
end
