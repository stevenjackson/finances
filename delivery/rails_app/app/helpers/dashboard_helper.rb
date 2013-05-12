module DashboardHelper
  def this_month_string
    month_string @month
  end

  def link_to_prev_month(options={})
    link_to_month(@month.prev_month, options)
  end

  def link_to_next_month(options={})
    link_to_month(@month.next_month, options)
  end

  def link_to_month(date, options={})
    link_to "#{month_string date}", month_path(date), options
  end

  def month_path(date)
    "/#{month_string date}/#{date.strftime("%Y")}"
  end 

  def month_string(date)
    "#{date.strftime('%B')}"
  end
end
