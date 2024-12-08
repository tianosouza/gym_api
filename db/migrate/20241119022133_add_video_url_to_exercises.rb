class AddVideoUrlToExercises < ActiveRecord::Migration[7.2]
  def change
    add_column :exercises, :video_url, :string
  end
end
