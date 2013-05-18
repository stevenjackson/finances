require 'watir-webdriver'


Before ('@guard') do
  @browser = browser('@guard')
end

Before do
  @browser = browser
  @database = TestDatabase.new
end

After do
  TransactionsFile.delete
end

def browser(tag=nil)
  return $browser unless $browser.nil?

  if('@guard' == tag)
    $browser = Watir::Browser.new :phantomjs
  else
    $browser = Watir::Browser.new :firefox
  end
end

at_exit do
  begin
    $browser.quit unless $browser.nil?
  rescue
  ensure
    $browser = nil
  end
end
