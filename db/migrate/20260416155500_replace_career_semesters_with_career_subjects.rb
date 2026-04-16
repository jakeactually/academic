class ReplaceCareerSemestersWithCareerSubjects < ActiveRecord::Migration[8.1]
  def up
    # Create the new career_subjects table
    create_table :career_subjects do |t|
      t.references :career, null: false, foreign_key: true
      t.references :subject, null: false, foreign_key: true
      t.integer :semester, null: false

      t.timestamps
    end

    add_index :career_subjects, [ :career_id, :subject_id ], unique: true

    # Migrate data from old tables to new table
    execute <<-SQL.squish
      INSERT INTO career_subjects (career_id, subject_id, semester, created_at, updated_at)
      SELECT cs.career_id, css.subject_id, CAST(cs.name AS INTEGER), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
      FROM career_semesters cs
      JOIN career_semester_subjects css ON css.career_semester_id = cs.id
      WHERE cs.name GLOB '[0-9]*'
    SQL

    # For non-numeric semester names, we'll skip them or default to 1
    execute <<-SQL.squish
      INSERT INTO career_subjects (career_id, subject_id, semester, created_at, updated_at)
      SELECT cs.career_id, css.subject_id, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
      FROM career_semesters cs
      JOIN career_semester_subjects css ON css.career_semester_id = cs.id
      WHERE cs.name NOT GLOB '[0-9]*'
    SQL

    # Drop old tables
    drop_table :career_semester_subjects
    drop_table :career_semesters
  end

  def down
    # Recreate old tables
    create_table :career_semesters do |t|
      t.references :career, null: false, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end

    add_index :career_semesters, [ :career_id, :name ], unique: true

    create_table :career_semester_subjects do |t|
      t.references :career_semester, null: false, foreign_key: true
      t.references :subject, null: false, foreign_key: true

      t.timestamps
    end

    add_index :career_semester_subjects, [ :career_semester_id, :subject_id ], unique: true, name: "idx_unique_career_semester_subjects"

    # Drop new table
    drop_table :career_subjects
  end
end
