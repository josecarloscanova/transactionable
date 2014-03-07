class RemoveTransactionLoggableFromTransactionableTransactions < ActiveRecord::Migration
  def change
    remove_column :transactionable_transactions, :transaction_loggable_id, :integer
    remove_column :transactionable_transactions, :transaction_loggable_type, :string
  end
end
