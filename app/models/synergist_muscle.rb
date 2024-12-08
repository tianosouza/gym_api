class SynergistMuscle < ApplicationRecord
  has_one_attached :muscule_file
  has_many :synergist_muscles_exercises
  has_many :exercises, through: :synergist_muscles_exercises

  validates :name, presence: true
end
