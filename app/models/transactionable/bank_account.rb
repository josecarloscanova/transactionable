module Transactionable
  class BankAccount < ActiveRecord::Base
    belongs_to :bank_accountable, polymorphic: true
    has_one :remote_bank_account, as: :local_entity, dependent: :destroy
    has_many :transactions, as: :transactionable
    has_many :credits, as: :transactionable
    has_many :reversals, as: :transactionable

    TYPES = ["checking", "savings"]

    def remote
      if remote_bank_account && remote_bank_account.synced?
        remote_bank_account.fetch
      end
    end

    def sync
      balanced_bank_account = remote
      self.bank_name = balanced_bank_account.bank_name
      self.description = balanced_bank_account.account_number
      self.name = balanced_bank_account.name
      self.can_debit = balanced_bank_account.can_debit
      self.account_type = balanced_bank_account.type
      save
    end

    def credit!(amount)
      remote_credit = remote.credit(amount: amount_in_cents(amount))
      transaction = Credit.create_from_remote(remote_credit)
      credits << transaction
    end

    def amount_in_cents(amount)
      (amount * 100).to_i
    end
  end
end
