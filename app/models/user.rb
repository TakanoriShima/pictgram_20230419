class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 15 }
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
  validates :password, length:{ in:8..32 }, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/}
  has_secure_password
end