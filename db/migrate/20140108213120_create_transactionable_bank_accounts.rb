class CreateTransactionableBankAccounts < ActiveRecord::Migration
  def change
    create_table :transactionable_bank_accounts do |t|
      t.integer :bank_accountable_id
      t.string :bank_accountable_type
      t.string :account_number
      t.string :name
      t.string :bank_name
      t.string :description
      t.string :account_type
      t.boolean :can_debit
      t.boolean :verified

      t.timestamps
    end
  end
end
