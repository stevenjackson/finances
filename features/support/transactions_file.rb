class TransactionsFile
  def self.write
    File.open(new.path, 'w') do |f|
      f.write new.file_contents
    end
  end

  def self.delete
    path = new.path
    File.delete path if File.exists? path
  end

  def path
    "#{FigNewton.import_folder}/test.csv"
  end

  def file_contents
    '''
04/19/2013,"ENERGY Bill Payment","-50.52","1715.78"
    '''
  end

end
