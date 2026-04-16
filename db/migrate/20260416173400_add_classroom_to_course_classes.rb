class AddClassroomToCourseClasses < ActiveRecord::Migration[8.1]
  def up
    # First add the column as nullable
    add_reference :course_classes, :classroom, foreign_key: true

    # Set a default classroom for existing records (first classroom)
    first_classroom_id = Classroom.first&.id || 1
    execute "UPDATE course_classes SET classroom_id = #{first_classroom_id} WHERE classroom_id IS NULL"

    # Now make it non-nullable
    change_column_null :course_classes, :classroom_id, false
  end

  def down
    remove_reference :course_classes, :classroom
  end
end
