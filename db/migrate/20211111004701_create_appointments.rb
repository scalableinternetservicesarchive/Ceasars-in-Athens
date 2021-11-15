class CreateAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      t.date :date
      t.datetime :start_time
      t.datetime :end_time
      t.references :service, null: false, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
