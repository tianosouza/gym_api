class CreateEquipamentExercises < ActiveRecord::Migration[7.2]
  def change
    create_table :equipament_exercises, id: false do |t|
      t.references :equipament, null: false, foreign_key: true
      t.references :exercise, null: false, foreign_key: true
    end
  end
end
