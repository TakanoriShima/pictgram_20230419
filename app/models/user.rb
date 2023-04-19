class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 15 }
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
  validates :password, length:{ in:8..32 }, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/}
  
  has_secure_password
  
  has_many :topics
  has_many :favorites
  has_many :favorite_topics, through: :favorites, source: 'topic'
  has_many :comments
  has_one :profile
  
  has_many :follows, foreign_key: 'user_id'
  has_many :followings, through: :follows, source: :follow
  has_many :reverses_of_follows, class_name: 'Follow', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_follows, source: :user
end
