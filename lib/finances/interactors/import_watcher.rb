require 'listen'

class Finances::ImportWatcher
  def initialize(gateway)
    @gateway = gateway
  end

  def run(params={})
    @listener = Listen.to(params[:import_path])
      .filter(/\.csv$/, /\.ofx$/)
      .ignore(%r{archive})
      .change(&callback)

    @listener.start
  end

  def stop
    @listener.stop
  end

  def callback
    Proc.new do |modified, added, removed |
      modified.each { |f| import f }
      added.each { |f| import f }
    end
  end

  def import(file)
    ImportFactory.new(@gateway).run file: file
  end

  def callback=(handler)
    @listener.change &handler
  end

end
