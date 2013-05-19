class TransactionsFile

  def write(account)
    @path = "#{IMPORT_FOLDER}/#{account}"
    @file_name = "#{@path}/test.csv"

    FileUtils.mkdir_p @path

    File.open(@file_name, 'w') do |f|
      f.write file_contents
    end
  end

  def delete
    FileUtils.rm_rf @path if @path
  end

  def file_contents
    '''
04/19/2013,"ENERGY Bill Payment","-50.52","1715.78"
    '''
  end

end
