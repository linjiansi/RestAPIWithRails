class ChangeUsersTable < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :token, :string
    change_column_null :users, :email, false
    change_column_null :users, :password_digest, false
  end
end
