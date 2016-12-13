class Product < ActiveRecord::Base
  belongs_to :category

  validates :name, :description, presence: true
  validates :pricing, numericality: { only_integer: true }

  has_many :comments,  :foreign_key => 'product_id', :class_name =>'Comment'
  has_many :likes, as: :likeable

  has_many :users, through: :likes
end
