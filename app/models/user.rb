class User < ApplicationRecord

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]\z/i

  has_secure_token :token, length: 36

  validates :email,
            length: { minimum: 6 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: true

  validates :password, length: { minimum: 6 }
end
