class BodyPartSerializer < ActiveModel::Serializer
  attributes :name

  has_many :exercises
end
