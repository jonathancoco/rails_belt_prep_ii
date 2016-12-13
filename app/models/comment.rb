class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  has_many :likes, as: :likeable
end
