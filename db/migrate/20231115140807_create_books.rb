class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.decimal :price, precision: 8, scale: 2, null: false
      t.integer :published_year
      t.string :genre

      t.timestamps null: false
    end
  end
end
