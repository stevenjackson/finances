require 'date'
module TimeHelper
  def last_month
    Time.new.to_date.prev_month.to_time
  end

  def this_month
    Time.new.to_time
  end

  def this_year
    Time.new.year
  end

  def this_month_string
    month_string this_month
  end

  def month_string month
    month.strftime("%B")
  end
end
