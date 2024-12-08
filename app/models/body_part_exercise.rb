class BodyPartExercise < ApplicationRecord
  belongs_to :body_part
  belongs_to :exercise
end
