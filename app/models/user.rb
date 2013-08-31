class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :posts
  has_many :comments
  has_and_belongs_to_many :roles

  # Stored role names as CamelCase, but access with underscores
  def role?(role)
      return !!self.roles.find_by_name(role.to_s.camelize)
  end
end
