require 'import_watcher_loader'

desc "Watch for transactions to import"
task :import_watcher => :environment do
  include ImportWatcherLoader

  start_watcher! ENV["RAILS_ENV"]
end
