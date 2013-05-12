require 'spec_helper'

describe ImportCsv do
  let(:gateway) { double 'gateway' }
  let(:action) { ImportCsv.new gateway }

  before(:all) do
    File.open('test.csv', 'w') { |f| f.write(csv_file) }
  end

  after(:all) do
    File.delete('test.csv')
  end

  before(:each) do
    gateway.stub(:file_path) { File.expand_path 'test.csv' }
    gateway.stub(:account_by_name) { Account.new(1, 'checking') }
    gateway.stub(:save)
    gateway.stub(:transactions_by_account_id) {[]}
  end

  it "finds a file to import" do
    action.run account: 'checking', file: 'test.csv'
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
    action.run account: 'checking', file: 'test.csv'
    action.transactions.count.should == 3
  end

  it "saves transactions" do
    gateway.should_receive(:save).with(kind_of(Transaction)).exactly(3).times
    action.run account: 'checking', file: 'test.csv'
  end

  it "saves all the data" do
    action.run account: 'checking', file: 'test.csv'
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
    action.run account: 'checking', file: 'test.csv'
    gateway.stub(:transactions_by_account_id) do
      action.transactions.map{ |t| Transaction.new(t.to_h) }
    end
    gateway.should_receive(:save).never
    action.run account: 'checking', file: 'test.csv'
  end

  it "doesn't count other accounts as dupes" do
    action.run account: 'checking', file: 'test.csv'
    gateway.should_receive(:save)
    action.run account: 'savings', file: 'test.csv'
  end

  def csv_file
  '''
Description,,Summary Amt.
Beginning balance as of 04/19/2013,,"1766.30"
Total credits,,"902.96"
Total debits,,"-400.48"
Ending balance as of 05/12/2013,,"1268.78"

Date,Description,Amount,Running Bal.
04/19/2013,Beginning balance as of 04/19/2013,,"1766.30"
04/19/2013,"ENERGY Bill Payment","-50.52","1715.78"
04/19/2013,"MUD NO. 144 Bill Payment","-41.11","1674.67"
04/22/2013,"CHECKCARD 0420 SPEEDWAY 09338 CLE CLEVELAND OH 24224433111101030759182","-10.57","1664.10"
  '''
  end
end
