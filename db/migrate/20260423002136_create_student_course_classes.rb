class CreateStudentCourseClasses < ActiveRecord::Migration[8.1]
  def change
    create_table :student_course_classes do |t|
      t.references :student, null: false, foreign_key: true
      t.references :course_class, null: false, foreign_key: true
      t.boolean :attending, default: false, null: false

      t.timestamps
    end
    add_index :student_course_classes, [:student_id, :course_class_id], unique: true
  end
end
