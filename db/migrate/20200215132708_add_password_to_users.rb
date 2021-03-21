class AddPasswordToUsers < ActiveRecord::Migration[6.0]
  def change
  	add_column :users, :password, :string, after: :email
  end
end
