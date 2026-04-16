class CreateCourseClasses < ActiveRecord::Migration[8.1]
  def change
    create_table :course_classes do |t|
      t.references :teacher, null: false, foreign_key: true
      t.references :subject, null: false, foreign_key: true

      t.timestamps
    end
  end
end
