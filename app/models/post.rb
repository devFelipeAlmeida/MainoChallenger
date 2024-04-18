class Post < ApplicationRecord
  belongs_to :user

  has_many_attached :images

  validates :images, presence: true

  has_many :likes
  has_many :likers, through: :likes, source: :user

  has_many :comments

  has_many :guest_comments
end
