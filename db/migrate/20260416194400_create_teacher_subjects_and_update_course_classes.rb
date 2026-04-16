class CreateTeacherSubjectsAndUpdateCourseClasses < ActiveRecord::Migration[8.1]
  def up
    # Create teacher_subjects table
    create_table :teacher_subjects do |t|
      t.references :teacher, null: false, foreign_key: true
      t.references :subject, null: false, foreign_key: true

      t.timestamps
    end

    add_index :teacher_subjects, [ :teacher_id, :subject_id ], unique: true

    # Add teacher_subject_id to course_classes
    add_reference :course_classes, :teacher_subject, foreign_key: true

    # Migrate existing data: create teacher_subjects from current course_classes
    execute <<-SQL.squish
      INSERT INTO teacher_subjects (teacher_id, subject_id, created_at, updated_at)
      SELECT DISTINCT teacher_id, subject_id, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
      FROM course_classes
    SQL

    # Update course_classes to reference teacher_subjects
    execute <<-SQL.squish
      UPDATE course_classes
      SET teacher_subject_id = (
        SELECT ts.id FROM teacher_subjects ts
        WHERE ts.teacher_id = course_classes.teacher_id
        AND ts.subject_id = course_classes.subject_id
        LIMIT 1
      )
    SQL

    # Make teacher_subject_id non-nullable
    change_column_null :course_classes, :teacher_subject_id, false

    # Remove old columns
    remove_index :course_classes, name: "idx_unique_teacher_schedule"
    remove_reference :course_classes, :teacher
    remove_reference :course_classes, :subject

    # Add new unique index on teacher_subject + schedule
    add_index :course_classes, [ :teacher_subject_id, :weekday, :dayhour ], unique: true, name: "idx_unique_teacher_subject_schedule"
  end

  def down
    # Add back old columns
    add_reference :course_classes, :teacher, foreign_key: true
    add_reference :course_classes, :subject, foreign_key: true

    # Restore data
    execute <<-SQL.squish
      UPDATE course_classes
      SET teacher_id = (
        SELECT ts.teacher_id FROM teacher_subjects ts
        WHERE ts.id = course_classes.teacher_subject_id
      ),
      subject_id = (
        SELECT ts.subject_id FROM teacher_subjects ts
        WHERE ts.id = course_classes.teacher_subject_id
      )
    SQL

    # Make them non-nullable (assuming data exists)
    change_column_null :course_classes, :teacher_id, false
    change_column_null :course_classes, :subject_id, false

    # Remove new index and add back old one
    remove_index :course_classes, name: "idx_unique_teacher_subject_schedule"
    add_index :course_classes, [ :teacher_id, :weekday, :dayhour ], unique: true, name: "idx_unique_teacher_schedule"

    # Remove teacher_subject_id
    remove_reference :course_classes, :teacher_subject

    # Drop teacher_subjects table
    drop_table :teacher_subjects
  end
end
