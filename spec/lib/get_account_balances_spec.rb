require 'spec_helper'

describe GetAccountBalances do
  let(:gateway) { double ('gateway') }
  let(:action) { GetAccountBalances.new gateway }
  let(:debit) { Transaction.new(account_id: 1, amount: -70 ) }
  let(:credit) { Transaction.new(account_id: 1, amount: 30 ) }

  before(:each) do
    gateway.stub(:accounts) { [Account.new(1, 'checking', 100)] }
  end


  it "subtracts debits from transaction balances" do
    gateway.stub(:transactions) {[ debit ]}
    action.run[:checking].should be 30
  end

  it "adds credit to transaction balances" do
    gateway.stub(:transactions) {[ credit ]}
    action.run[:checking].should be 130
  end

  it "calculates transaction balances" do
    gateway.stub(:transactions) {[ debit, credit ]}
    action.run[:checking].should be 60
  end
end
