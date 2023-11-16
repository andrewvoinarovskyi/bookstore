class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :total_price, precision: 8, scale: 2
      t.string :status

      t.timestamps null: false
    end
  end
end
