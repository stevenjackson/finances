require 'spec_helper'
describe Category do
  it "takes a hash constructor" do
    c = Category.new name: 'stuff', budget: 100
    c.name.should == 'stuff'
    c.budget.should == 100
  end

end
