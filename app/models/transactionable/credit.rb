module Transactionable
  class Credit < Transaction
    has_many :reversals

    def reverse!(reversal_amount = nil)
      ensure_valid_reversal(reversal_amount)
      remote_reversal = reversal_amount ? remote.reverse(amount: amount_in_cents(reversal_amount)) : remote.reverse
      transaction = Reversal.create_from_remote(remote_reversal)
      reversals << transaction
      transactionable.transactions << transaction
    end

    def max_reversal_amount
      amount - reversals.sum(:amount)
    end

    private

    def ensure_valid_reversal(reversal_amount)
      reversal_amount = reversal_amount ? reversal_amount : amount
      raise Exceptions::InvalidReversalAmount if reversal_amount > max_reversal_amount
    end

    def amount_in_cents(dollar_amount)
      (dollar_amount * 100).to_i
    end
  end
end
