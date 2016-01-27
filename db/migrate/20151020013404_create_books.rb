class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.float :price
      t.string :description
      t.string :swap
      t.string :condition
      t.integer :user_id
      t.integer :category_id
    end
  end
end
