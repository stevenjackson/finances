require 'listen'

class Finances::ImportWatcher
  def initialize(gateway)
    @gateway = gateway
  end

  def run(params={})
    @listener = Listen.to(params[:import_path], relative_paths: false)
      .filter(/\.csv$/, /\.ofx$/)
      .ignore(%r{archive})
      .change(&callback)

      puts "Now watching #{params[:import_path]}"
    @listener.start
  end

  def stop
    @listener.stop
  end

  def start!
    stop
    begin
      @listener.start!
    rescue Interrupt
      puts "Watcher stopping"
    end
  end

  def callback
    Proc.new do |modified, added, removed |
      modified.each { |f| import f }
      added.each { |f| import f }
    end
  end

  def import(file)
    begin
      ImportTransactionFactory.new(@gateway).run file: file
    rescue => e
      puts "Error during import of #{file}"
      puts "#{$!}"
      puts "Backtrace:\n\t#{e.backtrace.join("\n\t")}"
      raise
    end
  end

  def callback=(handler)
    @listener.change &handler
  end

end
