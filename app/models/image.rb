class Image < ActiveRecord::Base
 belongs_to :book
 mount_uploader :image, ImageUploader

end