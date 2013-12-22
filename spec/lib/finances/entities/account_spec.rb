require 'spec_helper'
describe Account do
  it "takes a hash constructor" do
    a = Account.new id: 1, name: 'stuff', balance: 100
    a.id.should == 1
    a.name.should == 'stuff'
    a.balance.should == 100
  end

end
