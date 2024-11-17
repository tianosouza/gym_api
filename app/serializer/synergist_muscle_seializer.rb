class SynergistMuscleSerializer < ActiveModel::Serializer
  attributes :name

  has_many :exercises
end
