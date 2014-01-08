class CreateTransactionableCreditCards < ActiveRecord::Migration
  def change
    create_table :transactionable_credit_cards do |t|
      t.integer :credit_cardable_id
      t.string :credit_cardable_type
      t.string :name
      t.string :description
      t.integer :last_four
      t.string :brand
      t.integer :expiration_month
      t.integer :expiration_year
      t.date :expiration_date

      t.timestamps
    end
  end
end
