class WorkoutSerializer < ActiveModel::Serializer
  attributes :id, :title, :description
  has_one :user, serializer: UserSerializer

  has_many :workout_exercises, dependent: :destroy
  has_many :exercises, through: :workout_exercises
end
