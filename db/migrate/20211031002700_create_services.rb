class CreateServices < ActiveRecord::Migration[6.1]
  def change
    create_table :services do |t|
      t.string :availability
      t.string :description
      t.string :title
      t.integer :zipcode
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
