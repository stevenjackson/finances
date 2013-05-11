describe GetAccountBalanceSheet do

  let(:gateway) { double 'gateway' }
  let(:action) { GetAccountBalanceSheet.new(gateway) }
  let(:checking) { Account.new 1, 'checking' }
  let(:checking_balance) { AccountBalance.new :account => checking }
  let(:transaction) { Transaction.new :account_id => 1, :amount => -50}

  before(:each) do
    gateway.stub(:accounts) { [checking] }
    gateway.stub(:account_balances) { [checking_balance] }
    gateway.stub(:transactions_by_account_id) { [transaction] }  
  end
  
  it "provides balances for the current month by default" do
    checking_balance.date = last_month
    checking_balance.balance = 80
    transaction.posted_at = this_month
    sheet = action.run
    sheet.first[:account].should == 'checking'
    sheet.first[:starting].should == 80
    sheet.first[:ending].should == 30
    sheet.first[:change].should == -50
  end

end
