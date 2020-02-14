class AddImageNameToUsers < ActiveRecord::Migration[6.0]
  def change
  	add_column :users, :image_name, :string, after: :email
  end
end
