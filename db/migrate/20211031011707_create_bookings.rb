class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.references :service, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :booking_time

      t.timestamps
    end
  end
end
