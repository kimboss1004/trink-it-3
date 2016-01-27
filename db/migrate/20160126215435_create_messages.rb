class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :text
      t.integer :book_id
      t.integer :reciever_id
      t.integer :sender_id
      t.boolean :viewed
      t.timestamps
    end
  end
end

