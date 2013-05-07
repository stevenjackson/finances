require 'date'
module TimeHelper
  def last_month
    Time.new.to_date.prev_month.to_time
  end
  def this_month
    Time.new
  end
end
