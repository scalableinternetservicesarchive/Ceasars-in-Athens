class CreateAvailabilities < ActiveRecord::Migration[6.1]
  def change
    create_table :availabilities do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :start
      t.datetime :end
      t.boolean :is_available
      t.boolean :is_recurring

      t.timestamps
    end
  end
end
