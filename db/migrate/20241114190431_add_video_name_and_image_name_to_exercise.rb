class AddVideoNameAndImageNameToExercise < ActiveRecord::Migration[7.2]
  def change
    add_column :exercises, :video_name, :string
    add_column :exercises, :image_name, :string
  end
end
