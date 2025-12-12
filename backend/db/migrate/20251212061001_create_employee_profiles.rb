class CreateEmployeeProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :employee_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.string :department, null: false

      t.timestamps
    end

    add_index :employee_profiles, :user_id, unique: true
  end
end
