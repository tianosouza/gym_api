class CreateTargetMusclesExercises < ActiveRecord::Migration[7.2]
  def change
    create_table :target_muscles_exercises do |t|
      t.references :target_muscle, null: false, foreign_key: true
      t.references :exercise, null: false, foreign_key: true

      t.timestamps
    end
  end
end
