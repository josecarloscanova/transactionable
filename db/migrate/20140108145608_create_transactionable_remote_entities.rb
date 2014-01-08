class CreateTransactionableRemoteEntities < ActiveRecord::Migration
  def change
    create_table :transactionable_remote_entities do |t|
      t.string :uri
      t.string :service_name
      t.integer :local_entity_id
      t.string :local_entity_type
      t.time :synced_at
      t.string :type

      t.timestamps
    end
  end
end
