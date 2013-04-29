require 'spec_helper'

describe ImportOfx do

  let(:gateway) { double("Gateway") }
  let(:action) { ImportOfx.new gateway }

  before(:all) do
    File.open('test.ofx', 'w'){|f| f.write(ofx_file) }
  end

  before(:each) do
    gateway.stub(:file_path) { File.expand_path 'test.ofx' }
    gateway.stub(:save)
    gateway.stub(:account_by_name) { Account.new(1, 'checking') }
    gateway.stub(:transactions_by_account_id) { [] }
  end

  after(:all) do
    File.delete('test.ofx')
  end

  it "finds a file to import" do
    action.run account: 'checking', file: 'text.ofx'
    action.should be_file_loaded
  end

  it "finds transactions" do
    action.run account: 'checking', file: 'text.ofx'
    action.transactions.count.should == 2
  end

  it "saves transactions" do
    gateway.should_receive(:save).with(kind_of(Transaction)).twice
    action.run account: 'checking', file: 'text.ofx'
  end

  it "saves all the data" do
    action.run account: 'checking', file: 'text.ofx'
    t = action.transactions.first
    t.id.should be_nil
    t.description.should == "GROCER A & Z"
    t.amount.should == -99
    t.account_id.should == 1
    t.fit_id.should == '00000000000000000000000004'
    t.amount_in_pennies.should == -9891
    t.nick_name.should be_nil
    t.posted_at.should == Time.new(2009, 2, 9)
    t.type.should == :debit
  end

  it "doesn't store dupes" do
    action.run account: 'checking', file: 'text.ofx'
    gateway.stub(:transactions_by_account_id) { action.transactions }
    gateway.should_receive(:save).never
    action.run account: 'checking', file: 'text.ofx'
  end

  it "doesn't count other accounts as dupes" do
    action.run account: 'checking', file: 'text.ofx'
    gateway.should_receive(:save).twice
    action.run account: 'savings', file: 'text.ofx'
  end



  def ofx_file
  '''
OFXHEADER:100
DATA:OFXSGML
VERSION:102
SECURITY:TYPE1
ENCODING:USASCII
CHARSET:1252
COMPRESSION:NONE
OLDFILEUID:NONE
NEWFILEUID:NONE


<OFX>
<SIGNONMSGSRSV1>
<SONRS>
<STATUS>
<CODE>0
<SEVERITY>INFO
<MESSAGE>OK
</STATUS>
<DTSERVER>20090211000000[-5:EST]
<USERKEY>--NoUserKey--
  <LANGUAGE>ENG
<INTU.BID>00002
</SONRS>
</SIGNONMSGSRSV1>
<BANKMSGSRSV1>
<STMTTRNRS>
<TRNUID>XXXX - 20090211000000
<STATUS>
<CODE>0
<SEVERITY>INFO
<MESSAGE>OK
</STATUS>
<STMTRS>
<CURDEF>CAD
<BANKACCTFROM>
<BANKID>000000000
<ACCTID>000000
<ACCTTYPE>CHECKING
</BANKACCTFROM>
<BANKTRANLIST>
<DTSTART>20090209
<DTEND>20090209000000[-5:EST]
<STMTTRN>
<TRNTYPE>DEBIT
<DTPOSTED>20090209000000[-5:EST]
<TRNAMT>-98.91
<FITID>00000000000000000000000004
<NAME>GROCER A & Z
</STMTTRN>
<STMTTRN>
<TRNTYPE>CREDIT
<DTPOSTED>20090209000000[-5:EST]
<TRNAMT>308.86
<FITID>00000000000000000000000007
<NAME>DEPOSIT    000000
</STMTTRN>
</BANKTRANLIST>
<LEDGERBAL>
<BALAMT>256.94
<DTASOF>20090209000000[-5:EST]
</LEDGERBAL>
<AVAILBAL>
<BALAMT>256.94
<DTASOF>20090211000000[-5:EST]
</AVAILBAL>
</STMTRS>
</STMTTRNRS>
</BANKMSGSRSV1>
</OFX>
  '''
  end
end
