require 'listen'

class Finances::ImportWatcher

  FILTERS = [/\.csv$/, /\.ofx$/]

  def initialize(gateway)
    @gateway = gateway
  end

  def run(params={})
    @listener = Listen.to(params[:import_path], ignore: %r{archive}, &callback)

      puts "Now watching #{params[:import_path]}"
    @listener.start
  end

  def stop
    begin
      @listener.stop
    rescue SystemExit
      puts "Watcher stopping"
    end
  end

  def callback
    @handler ||= default_callback
    filterer
  end

  def default_callback
    Proc.new do |modified, added, removed |
      modified.each { |f| import f }
      added.each { |f| import f }
    end
  end

  def filterer
    Proc.new do |modified, added, removed|
      @handler.call(filter(modified), filter(added), filter(removed))
    end
  end

  def filter(files)
    files.select do |file|
      FILTERS.any? { |filter| filter =~ file } 
    end
  end

  def import(file)
    begin
      ImportTransactionFile.new(@gateway).run file: file
    rescue => e
      puts "Error during import of #{file}"
      puts "#{$!}"
      puts "Backtrace:\n\t#{e.backtrace.join("\n\t")}"
      raise
    end
  end

  def callback=(handler)
    @handler = handler
  end

end
