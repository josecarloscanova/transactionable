module Transactionable
  class Debit < Transaction
    has_many :refunds

    def refund!(refund_amount = nil)
      ensure_valid_refund(refund_amount)
      remote_refund = refund_amount ? remote.refund(amount: amount_in_cents(refund_amount)) : remote.refund
      transaction = Transactionable::Refund.create_from_remote(remote_refund)
      refunds << transaction
      transactionable.transactions << transaction
    end

    def max_refund_amount
      amount - refunds.sum(:amount)
    end

    private

    def ensure_valid_refund(refund_amount)
      refund_amount = refund_amount ? refund_amount : amount
      raise Exceptions::InvalidRefundAmount if refund_amount > max_refund_amount
    end

    def amount_in_cents(dollar_amount)
      (dollar_amount * 100).to_i
    end
  end
end
