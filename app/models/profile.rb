class Profile < ApplicationRecord
  mount_uploader :profile_image, ImageUploader
  
  belongs_to :user
end
