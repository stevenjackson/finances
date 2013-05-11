module Finances::Bookkeeping
  def matches?(category, month, year)
    return false unless self.date_applied

    category == self.category and self.date_applied.to_date.month == month and self.date_applied.to_date.year == year
  end
end
