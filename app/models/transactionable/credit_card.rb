module Transactionable
  class CreditCard < ActiveRecord::Base
    belongs_to :credit_cardable, polymorphic: true
    has_one :remote_credit_card, as: :local_entity, dependent: :destroy
    has_many :transactions, as: :transactionable
    has_many :debits, as: :transactionable
    has_many :refunds, as: :transactionable

    def remote
      if remote_credit_card && remote_credit_card.synced?
        remote_credit_card.fetch
      end
    end

    def debit!(amount)
      # TODO: Consider whether to assume that this method takes
      # decimal/float dollar values
      remote_debit = remote.debit(amount: amount_in_cents(amount))
      transaction = Debit.create_from_remote(remote_debit)
      debits << transaction
    end

    def amount_in_cents(amount)
      (amount*100).to_i
    end

    def sync
      remote_cc = self.remote
      self.name = remote_cc.name
      self.description = "#{remote_cc.brand} (#{remote_cc.last_four})"
      self.last_four = remote_cc.last_four
      self.brand = remote_cc.brand
      self.expiration_month = remote_cc.expiration_month
      self.expiration_year = remote_cc.expiration_year
      self.expiration_date = Date.parse("#{expiration_month}/#{expiration_year}")
      save
    end
  end
end
