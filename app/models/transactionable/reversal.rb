module Transactionable
  class Reversal < Transaction
    belongs_to :credit
  end
end
