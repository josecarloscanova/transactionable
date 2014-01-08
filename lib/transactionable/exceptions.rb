module Transactionable
  module Exceptions
    class InvalidRefundAmount < StandardError; end
    class InvalidReversalAmount < StandardError; end
  end
end