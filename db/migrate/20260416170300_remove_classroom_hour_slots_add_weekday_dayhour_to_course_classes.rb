class RemoveClassroomHourSlotsAddWeekdayDayhourToCourseClasses < ActiveRecord::Migration[8.1]
  def up
    # Add new columns to course_classes
    add_column :course_classes, :weekday, :integer, null: false, default: 1
    add_column :course_classes, :dayhour, :integer, null: false, default: 1

    # Add index for uniqueness constraint
    add_index :course_classes, [ :teacher_id, :weekday, :dayhour ], unique: true, name: "idx_unique_teacher_schedule"

    # Drop the join table and classroom_hour_slots table
    drop_table :course_class_hour_slots
    drop_table :classroom_hour_slots
  end

  def down
    # Recreate classroom_hour_slots table
    create_table :classroom_hour_slots do |t|
      t.references :classroom, null: false, foreign_key: true
      t.string :label, null: false

      t.timestamps
    end

    add_index :classroom_hour_slots, [ :classroom_id, :label ], unique: true

    # Recreate course_class_hour_slots join table
    create_table :course_class_hour_slots do |t|
      t.references :course_class, null: false, foreign_key: true
      t.references :classroom_hour_slot, null: false, foreign_key: true

      t.timestamps
    end

    add_index :course_class_hour_slots, [ :course_class_id, :classroom_hour_slot_id ], unique: true, name: "idx_unique_course_class_hour_slots"

    # Remove columns from course_classes
    remove_index :course_classes, name: "idx_unique_teacher_schedule"
    remove_column :course_classes, :dayhour
    remove_column :course_classes, :weekday
  end
end
