class CreateProfileImage < ActiveRecord::Migration
  def change
    create_table :profile_images do |t|
    	t.string :profile_image
    	t.integer :user_id
    end
  end
end

