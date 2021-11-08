class AddLengthOfTimeToAService < ActiveRecord::Migration[6.1]
  def up
    change_column :services, :availability, 'integer USING CAST(availability AS integer)'
    rename_column :services, :availability, :length_of_time
  end
  def down
    rename_column :services, :length_of_time, :availability
    change_column :services, :availability, :string
  end
end
