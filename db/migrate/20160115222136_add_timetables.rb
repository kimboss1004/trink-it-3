class AddTimetables < ActiveRecord::Migration
  def change
    add_column :proposals, :created_at, :timestamp
    add_column :books, :created_at, :timestamp
  end
end
