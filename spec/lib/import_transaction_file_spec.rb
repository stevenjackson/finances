require 'spec_helper'
include ImportFiles

describe ImportTransactionFile do
  let(:gateway) { double 'gateway' }
  let(:action) { ImportTransactionFile.new gateway }

  before(:all) do
    @test_csv = 'import/checking/test.csv'
    @test_ofx = 'import/checking/test.ofx'
    @ignored_file = 'import/checking/test.qif'

    FileUtils.mkdir_p 'import/checking' 
  end

  after(:all) do
    FileUtils.rm_rf 'import'
  end

  before(:each) do
    File.open(@test_csv, 'w') {|f| f.write csv_file }
    File.open(@test_ofx, 'w') {|f| f.write ofx_file }
    gateway.stub(:account_by_name) { Account.new(1, 'checking') }
    gateway.stub(:transactions_by_account_id) { [] }
    gateway.stub(:save)
  end

  it "determines the account transactions belong to by directory name" do
    gateway.should_receive(:account_by_name).with('checking')
    action.run file: @test_csv
  end

  it "saves new transactions" do
    gateway.should_receive(:save).exactly(3).times.with(kind_of(Transaction))
    action.run file: @test_csv
  end

  it "handles ofx files" do
    gateway.should_receive(:account_by_name).with('checking')
    gateway.should_receive(:save).exactly(2).times.with(kind_of(Transaction))
    action.run file: @test_ofx
  end

  it "ignores other files" do
    gateway.should_not_receive(:account_by_name)
    action.run file: @ignored_file
  end

  it "archives files after import" do
    action.run file: @test_csv
    File.exist?(@test_csv).should be_false
    archive_csv = @test_csv.insert(@test_csv.index('/checking/'), '/archive')
    File.exist?(archive_csv).should be_true
  end
end
