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

      def acts_as_transaction_loggable(options = {})
        include Transactionable::TransactionLoggable
      end
    end
  end
end

ActiveRecord::Base.send :include, Transactionable::ActsAsTransactionable