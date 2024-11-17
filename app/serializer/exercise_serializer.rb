class ExerciseSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :video_url, :image_url, :exercise_type, :instructions, :is_favorite, :equipaments, :num_exercises

  belongs_to :user
  has_many :equipaments
  has_many :body_parts
  has_many :target_muscles
  has_many :synergist_muscles

  # def video_file
  #   Rails.application.routes.url_helpers.rails_blob_url(
  #     object.video_file,
  #     disposition: "inline",
  #     content_type: "video/mp4"
  #   ) if object.video_file.attached?
  # end
  
  
  # def image_file
  #   Rails.application.routes.url_helpers.rails_blob_url(
  #     object.image_file,
  #     disposition: "inline"
  #   ) if object.image_file.attached?
  # end 
  # 
  # Custom URL methods
  def video_url
    if object.video_file.attached?
      Rails.application.routes.url_helpers.rails_blob_url(object.video_file, host: "http://localhost:4000")
    end
  end

  def image_url
    if object.image_file.attached?
      Rails.application.routes.url_helpers.rails_blob_url(object.image_file, host: "http://localhost:4000")
    end
  end
  
  # def video_url
  #   Rails.application.routes.url_helpers.video_exercise_url(object, host: "http://localhost:4000") if object.video_file.attached?
  # end

  # def image_url
  #   Rails.application.routes.url_helpers.image_exercise_url(object, host: "http://localhost:4000") if object.image_file.attached?
  # end
end
