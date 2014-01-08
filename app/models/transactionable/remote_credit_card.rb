module Transactionable
  class RemoteCreditCard < RemoteEntity
    def remote_entity_type
      "Card"
    end
  end
end
