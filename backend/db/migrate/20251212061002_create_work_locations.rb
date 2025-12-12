class CreateWorkLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :work_locations do |t|
      t.references :user_profile, null: false, foreign_key: true, index: true
      t.string :status, null: false
      t.date :date, null: false

      t.timestamps
    end

    add_index :work_locations, :date
    add_index :work_locations, [:user_profile_id, :date], unique: true
  end
end
