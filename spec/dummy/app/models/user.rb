class User < ActiveRecord::Base
  acts_as_credit_card_transactionable
end
