class Exercise < ApplicationRecord
  belongs_to :user, optional: true
  has_many :equipament_exercises, class_name: "EquipamentExercise"
  has_many :equipaments, through: :equipament_exercises
  has_many :body_part_exercises
  has_many :body_parts, through: :body_part_exercises
  has_many :target_muscles_exercises
  has_many :target_muscles, through: :target_muscles_exercises
  has_many :synergist_muscles_exercises
  has_many :synergist_muscles, through: :synergist_muscles_exercises

  has_one_attached :image_file
  has_one_attached :video_file

  validates :name, presence: true
  validates :exercise_type, inclusion: { in: %w[weight_reps duration distance_durationC], allow_nil: true }
  validates :instructions, presence: true

  after_create :rename_attached_files

  private

  def rename_image_name(image_name)
    self.image_name = rename_file(image_name)
  end

  def rename(file)
    file_rename = file.gsub(/\d+/, " ").gsub("_", " ").gsub("-", " ").strip
    file_rename.split.map(&:capitalize).join(" ")
  end

  def rename_attached_files
    rename_file(image_file) if image_file.attached?
    rename_file(video_file) if video_file.attached?
  end

  def rename_file(file)
    sanitized_base = file.filename.base.gsub(/\d/, "").parameterize
    new_filename = "#{sanitized_base}.#{file.filename.extension}"

    file.blob.update(filename: new_filename)
  end
end
