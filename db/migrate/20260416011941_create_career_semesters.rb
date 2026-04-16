class CreateCareerSemesters < ActiveRecord::Migration[8.1]
  def change
    create_table :career_semesters do |t|
      t.references :career, null: false, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end

    add_index :career_semesters, [ :career_id, :name ], unique: true
  end
end
