class Finances::ImportTransactionFile
  def initialize(gateway)
    @gateway = gateway
  end

  def run(params)
    transactions = import params[:file]
    if(transactions && transactions.length > 0)
      archive params[:file]
    end
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
    import = ImportCsv.new(@gateway)
    import.run file: file, account_id: parse_account(file)
    import.transactions
  end

  def import_ofx(file)
    import = ImportOfx.new(@gateway)
    import.run file: file, account_id: parse_account(file)
    import.transactions
  end

  def parse_account(file)
    account = Pathname.new(file).parent.basename.to_s
    @gateway.account_by_name(account).id
  end

  def archive(file)
    orig_file = Pathname.new(file)
    parent = orig_file.parent.basename
    grandparent = orig_file.parent.parent.expand_path
    archive_file = "#{grandparent}/archive/#{parent}/#{orig_file.basename}"


    FileUtils.mkdir_p Pathname.new(archive_file).dirname
    FileUtils.mv orig_file.expand_path, archive_file
  end
end
