class Finances::ImportTransactionFile
  def initialize(gateway)
    @gateway = gateway
  end

  def run(params)
    import params[:file]
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
