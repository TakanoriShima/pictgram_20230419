class Comment < ApplicationRecord
  validates :topic_id, presence: true
  validates :user_id, presence: true
  validates :sentence, presence: true
end
