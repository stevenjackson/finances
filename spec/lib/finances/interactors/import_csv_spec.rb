require 'spec_helper'
include ImportFiles

describe ImportCsv do
  let(:gateway) { double 'gateway' }
  let(:action) { ImportCsv.new gateway }

  before(:all) do 
    File.open(test_file, 'w') { |f| f.write(csv_file) }
  end

  after(:all) do
    File.delete(test_file)
  end

  def test_file
    File.expand_path 'test.csv'
  end

  before(:each) do
    gateway.stub(:save)
    gateway.stub(:transactions_by_account_id) {[]}
  end

  it "finds a file to import" do
    action.run account_id: 1, file: test_file
    action.should be_file_loaded
  end

  it "parses dates in the mm/dd/yyyy format" do
    action.parse_date('03/07/2011').should == Date.new(2011, 3, 7).to_time
  end

  it "parses amounts into pennies" do
    action.parse_amount("-123.45").should == -12345
    action.parse_amount("123.45").should == 12345
    action.parse_amount("0.45").should == 45
  end

  it "finds transactions" do
    action.run account_id: 1, file: test_file
    action.transactions.count.should == 3
  end

  it "saves transactions" do
    gateway.should_receive(:save).with(kind_of(Transaction)).exactly(3).times
    action.run account_id: 1, file: test_file
  end

  it "saves all the data" do
    action.run account_id: 1, file: test_file
    t = action.transactions.first
    t.id.should be_nil
    t.description.should == "ENERGY Bill Payment"
    t.amount.should == 51
    t.account_id.should == 1
    t.fit_id.should be_nil
    t.amount_in_pennies.should == -5052
    t.nick_name.should be_nil
    t.posted_at.should == Time.new(2013, 4, 19)
    t.type.should == :debit
  end

  it "doesn't store dupes" do
    action.run account_id: 1, file: test_file
    gateway.stub(:transactions_by_account_id) do
      action.transactions.map{ |t| Transaction.new(t.to_h) }
    end
    gateway.should_receive(:save).never
    action.run account_id: 1, file: test_file
  end

  it "doesn't count other accounts as dupes" do
    action.run account_id: 1, file: test_file
    gateway.should_receive(:save)
    action.run account_id: 2, file: test_file
  end

end
