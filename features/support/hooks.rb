require 'watir-webdriver'



Before do
  @browser = Watir::Browser.new :firefox
  @database = TestDatabase.new
end


After do
  @browser.close
end
