class BodyPart < ApplicationRecord
  has_many :body_part_exercises
  has_many :exercises, through: :body_part_exercises

  validates :name, presence: true
end
