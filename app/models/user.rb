class User < ApplicationRecord
  has_many :book_users
  has_many :books, through: :book_users
  has_many :posts
  has_many :comments, as: :commentable
end
