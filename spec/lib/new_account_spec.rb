require 'spec_helper'

describe CreateAccount do
  let(:gateway) { double("Gateway") }
  let(:action) { CreateAccount.new gateway }

  before(:each) do
    gateway.stub(:accounts) { [Account.new(id: 1, name: "existing")] }
  end

  it "associates an account with a name and current balance" do
    gateway.should_receive(:save).with(kind_of(Account))
    action.run name: "test", balance: 100
  end

  it "checks for duplicate names before saving" do
    action.run name: "existing", balance: 100
    gateway.should_not_receive(:save)
  end
end
