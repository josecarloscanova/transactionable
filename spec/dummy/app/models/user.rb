class User < ActiveRecord::Base
  include Transactionable::BalancedCustomer
end
