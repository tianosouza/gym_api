class TargetMuscle < ApplicationRecord
  has_one_attached :muscule_file
  has_many :target_muscles_exercises
  has_many :exercises, through: :target_muscles_exercises

  validates :name, presence: true
end
