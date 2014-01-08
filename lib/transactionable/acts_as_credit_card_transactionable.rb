module Transactionable
  module ActsAsCreditCardTransactionable
    extend ActiveSupport::Concern

    module ClassMethods
      def acts_as_credit_card_transactionable(options = {})
        include Transactionable::CreditCardTransactionable
      end
    end
  end
end

ActiveRecord::Base.send :include, Transactionable::ActsAsCreditCardTransactionable