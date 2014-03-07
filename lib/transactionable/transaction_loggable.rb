module Transactionable
  module TransactionLoggable
    extend ActiveSupport::Concern

    included do
      has_many :transaction_logs, as: :transaction_loggable, class_name: 'Transactionable::TransactionLog'
      has_many :transactions, through: :transaction_logs, class_name: 'Transactionable::Transaction'

      def log_transaction(transaction)
        Transactionable::TransactionLog.create(transaction: transaction, transaction_loggable: self)
      end
    end
  end
end