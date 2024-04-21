class Post < ApplicationRecord

  belongs_to :user

  has_many_attached :images

  has_many :likes
  has_many :likers, through: :likes, source: :user

  has_many :comments

  has_many :guest_comments

  has_many :post_tags
  has_many :tags, through: :post_tags

  attr_accessor :tag_name

end