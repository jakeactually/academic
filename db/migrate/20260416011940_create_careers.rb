class CreateCareers < ActiveRecord::Migration[8.1]
  def change
    create_table :careers do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :careers, :name, unique: true
  end
end
