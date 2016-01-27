class ProfileImage < ActiveRecord::Base
	belongs_to :user
	mount_uploader :profile_image, ProfileImageUploader
end