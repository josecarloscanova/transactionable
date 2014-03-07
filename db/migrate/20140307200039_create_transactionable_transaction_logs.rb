class CreateTransactionableTransactionLogs < ActiveRecord::Migration
  def change
    create_table :transactionable_transaction_logs do |t|
      t.integer :transaction_id
      t.integer :transaction_loggable_id
      t.string :transaction_loggable_type

      t.timestamps
    end
  end
end
