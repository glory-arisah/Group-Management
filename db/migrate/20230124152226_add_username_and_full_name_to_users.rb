class AddUsernameAndFullNameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :username, :string
    add_column :users, :full_name, :string
  end
end
