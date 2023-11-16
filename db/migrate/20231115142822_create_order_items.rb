class CreateOrderItems < ActiveRecord::Migration[7.1]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.integer :quantity
      t.decimal :item_price, precision: 8, scale: 2

      t.timestamps null: false
    end
  end
end
