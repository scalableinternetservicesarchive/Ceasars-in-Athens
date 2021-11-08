class RemoveUserIndex < ActiveRecord::Migration[6.1]
  def up
    remove_index :users, name: "index_users_on_username"
  end
  def down
    add_index :users, :username, unique: true
  end
end
