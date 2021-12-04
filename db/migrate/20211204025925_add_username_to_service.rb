class AddUsernameToService < ActiveRecord::Migration[6.1]
  def change
    add_column :services, :user_name, :string
  end
end
