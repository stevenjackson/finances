require 'sequel'
require 'database_cleaner'
require 'database_cleaner/cucumber'

DatabaseCleaner.strategy = :truncation

Before do
    DatabaseCleaner.start
end

After do |scenario|
    DatabaseCleaner.clean
end
