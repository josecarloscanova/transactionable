class User < ActiveRecord::Base
  acts_as_credit_card_transactionable
  acts_as_bank_account_transactionable
  acts_as_transaction_loggable
end