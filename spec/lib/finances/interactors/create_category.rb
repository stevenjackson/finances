require 'spec_helper'

describe CreateCategory do
  let(:gateway) { double("Gateway") }
  let(:action) { CreateCategory.new gateway }

  before(:each) do
    gateway.stub(:categories) { [Category.new(name: "existing")] }
  end

  it "associates an category with a name and budget" do
    gateway.should_receive(:save).with(kind_of(Category))
    action.run name: "test", budget: 100
  end

  it "checks for duplicate names before saving" do
    action.run name: "existing", budget: 100
    gateway.should_not_receive(:save)
  end
end
