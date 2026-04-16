class CreateCourseClassHourSlots < ActiveRecord::Migration[8.1]
  def change
    create_table :course_class_hour_slots do |t|
      t.references :course_class, null: false, foreign_key: true
      t.references :classroom_hour_slot, null: false, foreign_key: true

      t.timestamps
    end

    add_index :course_class_hour_slots, [ :course_class_id, :classroom_hour_slot_id ], unique: true, name: "idx_unique_course_class_hour_slots"
  end
end
