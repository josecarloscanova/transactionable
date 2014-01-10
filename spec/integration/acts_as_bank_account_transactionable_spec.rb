require "spec_helper"

describe "#acts_as_bank_account_transactionable" do
  before(:each) { @user = User.create }

  specify { @user.class.should respond_to :acts_as_bank_account_transactionable }

  describe "#add_bank_account", :vcr, :marketplace do
    before(:each) do
      @user = User.create
      @balanced_bank_account = Balanced::BankAccount.new(
          name: "Mario",
          account_number: "9900000002",
          routing_number:  "021000021",
          type: "checking").save
      @user.add_bank_account(@balanced_bank_account.uri)
      @bank_account = @user.bank_accounts.first
    end

    specify { @user.bank_accounts.should_not be_blank }
    specify { @bank_account.remote_bank_account.uri.should_not be_blank }
    specify { @bank_account.description.should include "0002" }
  end
end