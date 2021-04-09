class User < ApplicationRecord
  has_secure_password
  has_many :books

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :email,
            presence: true,
            length: { minimum: 6 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: true

  validates :password,
            presence: true,
            length: { minimum: 6 }
end
