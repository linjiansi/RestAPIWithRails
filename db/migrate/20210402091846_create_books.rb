class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :name, null: false
      t.string :image
      t.integer :price
      t.string :purchase_date
      t.references :user, null: false

      t.timestamps
    end
    add_foreign_key :books, :users
  end
end
