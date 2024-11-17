class CreateSynergistMusclesExercises < ActiveRecord::Migration[7.2]
  def change
    create_table :synergist_muscles_exercises do |t|
      t.references :synergist_muscle, null: false, foreign_key: true
      t.references :exercise, null: false, foreign_key: true

      t.timestamps
    end
  end
end
