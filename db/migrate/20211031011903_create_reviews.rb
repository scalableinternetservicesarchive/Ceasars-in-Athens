class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :service, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :rating
      t.string :review

      t.timestamps
    end
  end
end
