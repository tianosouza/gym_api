class Equipament < ApplicationRecord
  # Associações
  has_many :equipament_exercises
  has_many :exercises, through: :equipament_exercises

  # Validações
  validates :name, presence: true
end
