class AddColumnConstraint < ActiveRecord::Migration[6.1]
  def change
    add_index :users, :email, unique: true
    change_column_null :books, :name, false
  end
end
