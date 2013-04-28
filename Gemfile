source 'https://rubygems.org'

# Specify your gem's dependencies in finances.gemspec
gemspec

#Old ofx is no longer being maintained and uses iconv
gem 'ofx', :git => 'git@github.com:floehopper/ofx.git'

group :test do
  gem "cucumber"
  gem "rspec"
  gem "page-object"
  gem "database_cleaner"

  gem "finances_data", :path => 'gateway'
end

group :development do
  gem "teamocil"
  gem "debugger"
  gem "guard-rspec"
  gem "guard-cucumber"
  gem 'fuubar'
  gem 'spork'
  gem 'guard-spork'
  gem 'fuubar-cucumber'
  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'growl'
end
