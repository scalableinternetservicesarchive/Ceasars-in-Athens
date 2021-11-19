class CleanupServicesTable < ActiveRecord::Migration[6.1]
  def change
    remove_column :services, :length_of_time
    remove_column :services, :zipcode
  end
end
