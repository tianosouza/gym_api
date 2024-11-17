class CreateBodyPartExercises < ActiveRecord::Migration[7.2]
  def change
    create_table :body_part_exercises do |t|
      t.references :body_part, null: false, foreign_key: true
      t.references :exercise, null: false, foreign_key: true

      t.timestamps
    end
  end
end
