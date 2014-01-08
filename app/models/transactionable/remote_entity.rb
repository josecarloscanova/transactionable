module Transactionable
  class RemoteEntity < ActiveRecord::Base
    belongs_to :local_entity, polymorphic: true

    before_destroy :destroy_remote

    def build_or_update_remote
      raise "Not Implemented"
    end

    def service_name
      read_attribute(:service_name) || "Balanced"
    end

    def build_remote
      raise "Not Implemented"
    end

    def update_remote
      raise "Not Implemented"
    end

    def synced?
      !!self.uri
    end

    def fetch
      if synced?
        "#{self.service_name}::#{remote_entity_type}".constantize.find(self.uri)
      end
    end

    def remote_entity_type
      "#{self.class.name.gsub("Transactionable::Remote","")}"
    end

    def destroy_remote
      re = self.fetch
      re.unstore if re
    end
  end
end
