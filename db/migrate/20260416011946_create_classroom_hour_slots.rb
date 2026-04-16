class CreateClassroomHourSlots < ActiveRecord::Migration[8.1]
  def change
    create_table :classroom_hour_slots do |t|
      t.references :classroom, null: false, foreign_key: true
      t.string :label, null: false

      t.timestamps
    end

    add_index :classroom_hour_slots, [ :classroom_id, :label ], unique: true
  end
end
