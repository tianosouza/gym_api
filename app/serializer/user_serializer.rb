class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :username, :email, :role

  # Vide specification
  # belongs_to :object do
  #   link(:related) { object_url(object.id) }
  # end

  link(:self) { users_url(object.id) }
end
