class TargetMusclesExercise < ApplicationRecord
  belongs_to :exercise
  belongs_to :target_muscle
end
