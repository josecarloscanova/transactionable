module Transactionable
  class TransactionLog < ActiveRecord::Base
    belongs_to :transaction
    belongs_to :transaction_loggable, polymorphic: true
  end
end
