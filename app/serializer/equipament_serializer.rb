class EquipamentSerializer < ActiveModel::Serializer
  attributes :name, :id

  has_many :equipament_exercises
  has_many :exercises, through: :equipament_exercises
end
