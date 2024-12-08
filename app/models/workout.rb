class Workout < ApplicationRecord
  belongs_to :user

  has_many :exercises

  validates :title, presence: true
  validates :description, presence: true
end
