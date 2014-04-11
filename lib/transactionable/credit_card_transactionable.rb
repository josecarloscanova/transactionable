module Transactionable
  module CreditCardTransactionable
    extend ActiveSupport::Concern
    include BalancedCustomer

    included do
      has_many :credit_cards, as: :credit_cardable, dependent: :destroy, class_name: "Transactionable::CreditCard"

      def add_credit_card(balanced_uri, credit_card = {})
        self.credit_cards.destroy_all if one_card?
        credit_card = self.credit_cards.create
        remote_card = Transactionable::RemoteCreditCard.create(uri: balanced_uri, local_entity: credit_card)
        credit_card.reload.sync
        sync_customer
        self.reload.remote.add_card(balanced_uri)
      end

      def one_card?
        false
      end
    end
  end
end