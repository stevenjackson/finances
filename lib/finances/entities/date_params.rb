module Finances::DateParams

  def parse_date(params)
    month = parse_month params[:month]
    year = params[:year] || Time.new.to_date.year
    [month, year]
  end

  def parse_month(month) 
    case month
    when nil
      Time.new.to_date.month
    when String
      Date.strptime(month, "%b").month
    when Fixnum
      month
    end
  end
end
