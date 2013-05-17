require 'spec_helper'
include ImportFiles

describe ImportWatcher do
  let(:gateway) { double 'gateway' }
  let(:action) { ImportWatcher.new gateway }

  before(:all) { }
  after(:all) { }

  before(:each) do
    gateway.stub(:account_by_name) { Account.new(1, 'checking') }
    gateway.stub(:transactions_by_account_id) { [] }
    gateway.stub(:save)
    FileUtils.mkdir_p 'import/checking' 
    action.run import_path: 'import'
  end

  after(:each) do
    action.stop
    FileUtils.rm_rf 'import'
  end

  it "determines the account transactions belong to by directory name" do
    gateway.should_receive(:account_by_name).with('checking')
    File.open('import/checking/test.csv', 'w') {|f| f.write csv_file }
    sleep(0.5)
  end

  it "saves new transactions" do
    gateway.should_receive(:save).exactly(3).times.with(kind_of(Transaction))
    File.open('import/checking/test.csv', 'w') {|f| f.write csv_file }
    sleep(0.5)
  end

  it "handles ofx files" do
    gateway.should_receive(:account_by_name).with('checking')
    gateway.should_receive(:save).exactly(2).times.with(kind_of(Transaction))
    File.open('import/checking/test.ofx', 'w') {|f| f.write ofx_file }
    sleep(0.5)
  end

  it "ignores other files" do
    gateway.should_not_receive(:account_by_name)
    File.open('import/checking/test.qif', 'w') {|f| f.write ofx_file }
    sleep(0.5)
  end
end
