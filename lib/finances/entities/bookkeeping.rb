module Finances::Bookkeeping
  def matches?(category, month, year)
    category == self.category and in_month? month, year 
  end

  def in_month?(month, year)
    return false unless self.date_applied

    self.date_applied.to_date.month == month and self.date_applied.to_date.year == year
  end
end
