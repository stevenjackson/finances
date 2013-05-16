require 'spec_helper'
include ImportFiles

describe ImportOfx do

  let(:gateway) { double("Gateway") }
  let(:action) { ImportOfx.new gateway }

  before(:all) do
    File.open(test_file, 'w'){|f| f.write(ofx_file) }
  end

  after(:all) do
    File.delete(test_file)
  end

  def test_file
    File.expand_path 'test.ofx'
  end

  before(:each) do
    gateway.stub(:save)
    gateway.stub(:account_by_name) { Account.new(1, 'checking') }
    gateway.stub(:transactions_by_account_id) { [] }
  end

  it "finds a file to import" do
    action.run account: 'checking', file: test_file
    action.should be_file_loaded
  end

  it "finds transactions" do
    action.run account: 'checking', file: test_file
    action.transactions.count.should == 2
  end

  it "saves transactions" do
    gateway.should_receive(:save).with(kind_of(Transaction)).twice
    action.run account: 'checking', file: test_file
  end

  it "saves all the data" do
    action.run account: 'checking', file: test_file
    t = action.transactions.first
    t.id.should be_nil
    t.description.should == "GROCER A & Z"
    t.amount.should == 99
    t.account_id.should == 1
    t.fit_id.should == '00000000000000000000000004'
    t.amount_in_pennies.should == -9891
    t.nick_name.should be_nil
    t.posted_at.should == Time.new(2009, 2, 9)
    t.type.should == :debit
  end

  it "doesn't store dupes" do
    action.run account: 'checking', file: test_file
    gateway.stub(:transactions_by_account_id) { action.transactions }
    gateway.should_receive(:save).never
    action.run account: 'checking', file: test_file
  end

  it "doesn't count other accounts as dupes" do
    action.run account: 'checking', file: test_file
    gateway.should_receive(:save).twice
    action.run account: 'savings', file: test_file
  end
end
