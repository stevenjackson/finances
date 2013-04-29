require 'watir-webdriver'


browser = Watir::Browser.new :firefox

Before do
  @browser = browser
  @database = TestDatabase.new
end


at_exit do
  browser.close
end
