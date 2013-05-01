require 'spec_helper'
describe Transaction do
  it "takes a hash constructor" do
    t = Transaction.new id: 1, amount: 100, description: 'stuff'
    t.id.should == 1
    t.amount.should == 100
    t.description.should == 'stuff'
  end

  it "stores negative amounts as debits" do
    t = Transaction.new
    t.amount = -100
    t.amount.should == 100
    t.type.should == :debit
  end

  it "stores positive amounts as credits" do
    t = Transaction.new
    t.amount = 100
    t.amount.should == 100
    t.type.should == :credit
  end

end
