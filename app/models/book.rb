class Book < ApplicationRecord
  belongs_to :created_by, class_name: 'User', optional: true
  has_many :book_users
  has_many :users, through: :book_users
end
