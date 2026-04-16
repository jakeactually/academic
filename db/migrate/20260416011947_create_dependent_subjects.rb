class CreateDependentSubjects < ActiveRecord::Migration[8.1]
  def change
    create_table :dependent_subjects do |t|
      t.references :subject, null: false, foreign_key: true
      t.references :dependent_subject, null: false, foreign_key: { to_table: :subjects }

      t.timestamps
    end

    add_index :dependent_subjects, [ :subject_id, :dependent_subject_id ], unique: true, name: "idx_unique_subject_dependencies"
  end
end
