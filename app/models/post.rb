class Post < ActiveRecord::Base
  #thumbs_up gem
  acts_as_voteable

  has_many :comments, dependent: :destroy
  belongs_to :user

  validates :title, presence: true, length: {maximum: 32}
  validates :location, presence: true, length: {maximum: 100}
  validates :adtext, presence: true, length: {maximum: 500}
validates :costOfFifteen, presence: true
#validates :costOfFifteen, :format => { :with => /\A\d+??(?:\.\d{0,2})?\z/ }, :numericality => {:greater_than => 0, :less_than => 1000}

validates :costOfThirty, :format => { :with => /\A\d+??(?:\.\d{0,2})?\z/ }, :numericality => {:greater_than => 0, :less_than => 1000} 
validates :costOfFifty, :format => { :with => /\A\d+??(?:\.\d{0,2})?\z/ }, :numericality => {:greater_than => 0, :less_than => 1000} 
#validates :numberofpeople, :numericality => { :greater_than_or_equal_to => 0 }
#  validates :budget, :numericality => { :greater_than_or_equal_to => 0 }

  scope :one_day_ago, lambda { where("created_at >= :date", :date => 1.days.ago) }
  scope :one_week_ago, lambda { where("created_at >= :date", :date => 1.weeks.ago) }
  scope :one_month_ago, lambda { where("created_at >= :date", :date => 1.months.ago) }

end
