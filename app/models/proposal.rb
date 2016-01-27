class Proposal < ActiveRecord::Base
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  belongs_to :reciever, class_name: "User", foreign_key: "reciever_id"
  belongs_to :book

  validates :date, presence: true
  validates :time, presence: true
  validates :location, presence: true
  validates :book_id, presence: true
  validates :sender_id, presence: true
  validates :reciever_id, presence: true

  def buyer
    if sender != book.user 
      return sender
    else
      return reciever
    end
  end
end