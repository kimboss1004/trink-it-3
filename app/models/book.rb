class Book < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :images
  has_many :proposals, dependent: :destroy
  belongs_to :college 


  validates :price, presence: true
  validates :title, presence: true
  validates :condition, presence: true
  validates :category, presence: true
  validates :user, presence: true



end