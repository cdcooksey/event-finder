class CreateReceipts < ActiveRecord::Migration[5.0]
  def change
    create_table :receipts do |t|
      t.references :store, foreign_key: true
      t.references :customer, foreign_key: true
      t.float :total_amount
      t.integer :total_items

      t.timestamps
    end
  end
end
