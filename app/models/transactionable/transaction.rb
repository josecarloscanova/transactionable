module Transactionable
  class Transaction < ActiveRecord::Base
    has_one :remote_transaction, as: :local_entity, dependent: :destroy
    belongs_to :transactionable, polymorphic: true
    has_many :transaction_logs

    TRANSACTION_TYPES = [:hold, :credit, :debit, :refund, :reversal]

    def self.create_from_remote(remote_trans)
      transaction = create(
        amount: remote_trans.amount/100.0,
        status: remote_trans.status,
        description: remote_trans.description
      )
      RemoteTransaction.create(local_entity: transaction, uri: remote_trans.uri)
      transaction
    end

    def remote
      if remote_transaction && remote_transaction.synced?
        remote_transaction.fetch
      end
    end
  end
end
