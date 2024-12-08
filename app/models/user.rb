class User < ApplicationRecord
  has_secure_password

  has_many :workouts
  has_many :exercises

  with_options if: :is_client? do |client|
    client.validates :first_name, presence: true
    client.validates :last_name, presence: true
    client.validates :username, uniqueness: true, length: { minimum: 10, maximum: 16 }
    client.validates :password, length: { minimum: 10 }
    client.validates :email, uniqueness: true, presence: true
    client.validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  end

  with_options if: :is_admin? do |admin|
    admin.validates :username, uniqueness: true, length: { minimum: 10, maximum: 16 }
    admin.validates :password, length: { minimum: 10 }
    admin.validates :email, uniqueness: true, presence: true
    admin.validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  end

  def is_client?
    role == "client"
  end

  def is_admin?
    role == "admin"
  end
end
