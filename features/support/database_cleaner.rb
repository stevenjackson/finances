require 'sequel'
require 'database_cleaner'
require 'database_cleaner/cucumber'

DatabaseCleaner[:sequel, {:connection => Sequel.connect(DB_URI)}].strategy = :truncation

Before do
    DatabaseCleaner.start
end

After do |scenario|
    DatabaseCleaner.clean
end
