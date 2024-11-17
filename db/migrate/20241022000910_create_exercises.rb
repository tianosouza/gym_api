class CreateExercises < ActiveRecord::Migration[7.2]
  def change
    create_table :exercises do |t|
      t.string :name
      t.string :instructions
      t.string :exercise_type
      t.boolean :is_favorite, default: false, null: true
      t.integer :num_exercises
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
  end
end
