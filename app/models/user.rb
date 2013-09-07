class User < ActiveRecord::Base
  # Thumbs_up gem
  acts_as_voter

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :setup_default_role_for_new_users

  has_many :posts
  has_many :comments
#  has_and_belongs_to_many :roles

  ROLES = %w[admin default banned]

# Stored role names as CamelCase, but access with underscores
  def role?(role)
      return !!self.roles.find_by_name(role.to_s.camelize)
  end

  private

  def setup_default_role_for_new_users
    if self.role.blank?
      self.role = "default"
    end
  end

end
