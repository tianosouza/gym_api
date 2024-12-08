class ExerciseSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :image, :video, :exercise_type, :instructions, :is_favorite, :equipaments, :num_exercises, :video_name, :image_name

  # belongs_to :user
  has_many :equipaments
  has_many :body_parts
  has_many :target_muscles
  has_many :synergist_muscles

  def image
    rails_blob_url(object.image_file, only_path: true) if object.image_file.attached?
  end

  def video
    rails_blob_url(object.video_file, only_path: true) if object.video_file.attached?
  end

end
