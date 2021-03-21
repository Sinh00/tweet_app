class ChangeUsersColumns < ActiveRecord::Migration[6.0]
  def change
  	add_column :users, :password_digest, :string, after: :email
    remove_column :users, :password, :string
  end
end
