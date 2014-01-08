class CreateTransactionableTransactions < ActiveRecord::Migration
  def change
    create_table :transactionable_transactions do |t|
      t.integer :transactionable_id
      t.string :transactionable_type
      t.integer :transaction_loggable_id
      t.string :transaction_loggable_type
      t.integer :credit_id
      t.integer :debit_id
      t.decimal :amount, precision: 8, scale: 2
      t.string :status
      t.string :description
      t.string :type

      t.timestamps
    end
  end
end
