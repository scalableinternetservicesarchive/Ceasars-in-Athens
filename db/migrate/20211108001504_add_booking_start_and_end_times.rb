class AddBookingStartAndEndTimes < ActiveRecord::Migration[6.1]
  def up
    rename_column :bookings, :booking_time, :booking_start_time
    add_column :bookings, :booking_end_time, :datetime
  end
  def down
    remove_column :bookings, :booking_end_time
    rename_column :bookings, :booking_start_time, :booking_time
  end
end
