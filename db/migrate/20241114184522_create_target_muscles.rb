class CreateTargetMuscles < ActiveRecord::Migration[7.2]
  def change
    create_table :target_muscles do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
