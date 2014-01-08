module Transactionable
  module ActsAsTransactionable
    extend ActiveSupport::Concern

    module ClassMethods
      def acts_as_credit_card_transactionable(options = {})
        include Transactionable::CreditCardTransactionable
      end

      def acts_as_bank_account_transactionable(options = {})
        include Transactionable::BankAccountTransactionable
      end
    end
  end
end

ActiveRecord::Base.send :include, Transactionable::ActsAsTransactionable