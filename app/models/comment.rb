class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  validates :body, presence: true, length: {maximum: 140}
end
