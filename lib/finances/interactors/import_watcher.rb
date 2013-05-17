require 'listen'

class Finances::ImportWatcher
  def initialize(gateway)
    @gateway = gateway
  end

  def run(params={})
    @listener = Listen.to(params[:import_path])
      #listener.ignore(%r{archive})
      #.filter(/\.csv$/, /\.ofx$/)
    @listener.change(&callback)
    @listener.start
  end

  def stop
    @listener.stop
  end

  def callback
    Proc.new do |modified, added, removed |
      handle_modified(modified)
      handle_added(added)
    end
  end

  def handle_modified(modified)
    modified.each { |f| import f }
  end

  def handle_added(added)
    added.each { |f| import f }
  end

  def import(file_path)
    case file_path
    when /\.csv$/
      import_csv file_path
    when /\.ofx$/
      import_ofx file_path
    end
  end

  def import_csv(file)
    ImportCsv.new(@gateway).run file: file, account_id: parse_account(file)
  end

  def import_ofx(file)
    ImportOfx.new(@gateway).run file: file, account_id: parse_account(file)
  end

  def parse_account(file)
    account = Pathname.new(file).parent.basename.to_s
    @gateway.account_by_name(account).id
  end
end
