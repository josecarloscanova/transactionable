require "spec_helper"

describe "#acts_as_credit_card_transactionable" do
  before(:each) { @user = User.create }

  specify { @user.class.should respond_to :acts_as_credit_card_transactionable }

  describe "#sync_customer", :vcr, :marketplace do
    before(:each) do 
      @user = User.create
      @user.sync_customer
      @user.reload
    end

    specify { @user.remote_customer.should_not be_blank }
    specify { @user.remote_customer.uri.should_not be_blank }
  end

  describe "#remote", :vcr, :marketplace do
    before(:each) do
      @user = User.create
      @user.sync_customer
      @user.reload
      @remote_customer = @user.remote_customer.fetch
    end

    specify { @user.remote.should be_instance_of Balanced::Customer }
    specify { @user.remote.attributes.should eql @remote_customer.attributes }
  end

  describe "#add_credit_card", :vcr, :marketplace do
    before(:each) do
      @user = User.create
      @balanced_card = Balanced::Card.new(
          card_number:      '4111111111111111',
          expiration_year:  (Date.today+2.years).year,
          expiration_month: '12').save
      @user.add_credit_card(@balanced_card.uri)
      @credit_card = @user.credit_cards.first
    end

    specify { @user.credit_cards.should_not be_blank }
    specify { @credit_card.remote_credit_card.uri.should_not be_blank }
    specify { @credit_card.last_four.should eql 1111 }
  end
end