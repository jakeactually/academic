class CreateCareerSemesterSubjects < ActiveRecord::Migration[8.1]
  def change
    create_table :career_semester_subjects do |t|
      t.references :career_semester, null: false, foreign_key: true
      t.references :subject, null: false, foreign_key: true

      t.timestamps
    end

    add_index :career_semester_subjects, [ :career_semester_id, :subject_id ], unique: true, name: "idx_unique_career_semester_subjects"
  end
end
