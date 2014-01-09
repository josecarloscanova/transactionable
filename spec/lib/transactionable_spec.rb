require 'spec_helper'

describe Transactionable do
  specify { ActiveRecord::Base.should respond_to(:acts_as_credit_card_transactionable) }
  specify { ActiveRecord::Base.should respond_to(:acts_as_bank_account_transactionable) }
end