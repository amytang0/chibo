class Post < ActiveRecord::Base
  #thumbs_up gem
  acts_as_voteable

  has_many :comments, dependent: :destroy
  belongs_to :user

  validates :title, presence: true, length: {maximum: 32}
  validates :whitetext, presence: true, length: {maximum: 140}
  validates :blacktext, presence: true, length: {maximum: 140}
end
