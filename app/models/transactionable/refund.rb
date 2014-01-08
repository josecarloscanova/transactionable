module Transactionable
  class Refund < Transaction
    belongs_to :credit
  end
end
