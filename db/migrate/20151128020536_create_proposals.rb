class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.integer :sender_id
      t.integer :reciever_id
      t.integer :book_id
      t.date :date
      t.time :time
      t.string :message
      t.string :location
      t.boolean :sender_confirmation
      t.boolean :reciever_confirmation
    end
  end
end
