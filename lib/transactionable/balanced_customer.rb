module Transactionable
  module BalancedCustomer
    extend ActiveSupport::Concern

    included do
      has_one :remote_customer, as: :local_entity, dependent: :destroy, class_name: "Transactionable::RemoteCustomer"
      
      def sync_customer
        if remote_customer
          remote_customer.build_or_update_remote
        else
          Transactionable::RemoteCustomer.create(local_entity: self)
        end
      end

      def remote
        if remote_customer && remote_customer.synced?
          remote_customer.fetch
        end
      end
    end
  end
end