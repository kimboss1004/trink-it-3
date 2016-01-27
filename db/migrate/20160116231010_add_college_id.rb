class AddCollegeId < ActiveRecord::Migration
  def change
    add_column :books, :college_id, :integer
    add_column :users, :college_id, :integer
  end
end
