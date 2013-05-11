require 'finances'
require 'rspec'

include Finances

def this_month
  Time.new
end

def last_month
  Time.new.to_date.prev_month.to_time
end

def next_month
  Time.new.to_date.next_month.to_time
end

def jan_this_year
  Date.new(Date.today.year, 1, 1).to_time
end

def jan_last_year
  Date.new(Date.today.year, 1, 1).prev_year.to_time
end
