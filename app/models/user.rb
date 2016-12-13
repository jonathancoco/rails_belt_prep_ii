class User < ActiveRecord::Base
  has_secure_password
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

  validates :name, :email, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }

  has_many :comments,  :foreign_key => 'user_id', :class_name =>'Comment'
  has_many :products, through: :comments

  #has_many :product_comments, :foreign_key => 'user_id', :class_name  => 'Comment'
  #has_many :products_commented_on , through: :product_comments, :foreign_key => 'product_id', :source => 'product'
end
