class DropAvailabilitiesAndBookings < ActiveRecord::Migration[6.1]
  def change
    drop_table(:bookings)
    drop_table(:availabilities)
  end
end
