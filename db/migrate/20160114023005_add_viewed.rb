class AddViewed < ActiveRecord::Migration
  def change
    add_column :proposals, :viewed, :boolean
    remove_column :proposals, :sender_confirmation
  end
end
