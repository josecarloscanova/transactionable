require "spec_helper"

def setup_user_with_credit_card
  @user = User.create
  @balanced_card = Balanced::Card.new(
    card_number:      '4111111111111111',
    expiration_year:  (Date.today+2.years).year,
    expiration_month: '12').save
  @user.add_credit_card(@balanced_card.uri)
end

describe "Transactionable::CreditCard" do
  describe "#debit!", :vcr, :marketplace do
    before do
      setup_user_with_credit_card
      @credit_card = @user.credit_cards.first
      @credit_card.debit!(13.37)
      @transaction = @credit_card.transactions.first
      @remote_transaction = @transaction.remote
    end

    specify { @credit_card.debits.should_not be_blank }
    specify { @credit_card.debits.first.should eql @transaction }
    specify { @transaction.should be_instance_of Transactionable::Debit }
    specify { @remote_transaction.should be_instance_of Balanced::Debit }
    specify { (@transaction.amount*100).should eql @remote_transaction.amount }
  end
end