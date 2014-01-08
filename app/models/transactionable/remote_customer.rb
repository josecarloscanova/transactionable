module Transactionable
  class RemoteCustomer < RemoteEntity
    before_create :build_or_update_remote

    def build_or_update_remote
      build_remote unless synced?
      update_remote
    end

    def build_remote
      balanced_customer = Balanced::Customer.new.save
      self.uri = balanced_customer.uri
      self.synced_at = Time.now
    end

    def update_remote
      balanced_customer = fetch
      if self.local_entity.respond_to?(:sync_attributes)
        balanced_customer_attributes = local_entity.sync_attributes
        non_address_keys = [:name, :email, :phone]
        new_customer_attributes = balanced_customer_attributes.reject { |k,v| v.blank? }
        address = new_customer_attributes.slice!(*non_address_keys)
        new_customer_attributes.merge!(address: address)
        new_customer_attributes.each { |k,v| balanced_customer.send("#{k}=", v) }
        balanced_customer.save
      else
        balanced_customer = fetch
        balanced_customer.name = "#{self.local_entity_type} #{self.local_entity_id}"
        balanced_customer.meta = {
                                    entity: self.local_entity_type,
                                    entity_id: self.local_entity_id
                                 }
        balanced_customer.save
      end
      update_attribute(:synced_at, Time.now) unless new_record?
      balanced_customer
    end
  end
end
