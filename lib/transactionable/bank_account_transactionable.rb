module Transactionable
  module BankAccountTransactionable
    extend ActiveSupport::Concern
    include BalancedCustomer

    included do
      has_many :bank_accounts, as: :bank_accountable, dependent: :destroy, class_name: "Transactionable::BankAccount"

      def add_bank_account(balanced_uri)
        bank_accounts.destroy_all if one_bank_account?
        bank_account = bank_accounts.create
        remote_account = RemoteBankAccount.create(uri: balanced_uri, local_entity: bank_account)
        bank_account.reload.sync
        sync_customer
        self.reload.remote.add_bank_account(balanced_uri)
      end

      def one_bank_account?
        false
      end
    end
  end
end