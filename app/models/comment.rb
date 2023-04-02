class Comment < ApplicationRecord
  validates :topic_id, presence: true
  validates :user_id, presence: true
  validates :sentence, presence: true
  
  belongs_to :topic
  belongs_to :user
  has_many :comment_sentence, through: :comments, source: 'sentence'
end
