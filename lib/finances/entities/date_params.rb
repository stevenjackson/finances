module Finances::DateParams

  def parse_date(params)
    month = parse_month params[:month]
    year = parse_year params[:year]
    [month, year]
  end

  def parse_month(month)
    case month
    when nil
      Date.today.month
    when String
      Date.strptime(month, "%b").month
    when Fixnum
      month
    end
  end

  def parse_year(year)
    case year
    when nil
      Date.today.year
    when String
      year.to_i
    when Fixnum
      year
    end
  end

  def short_date_for(date)
    date.strftime "%b-%-d"
  end
end
