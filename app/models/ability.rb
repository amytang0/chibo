class Ability
  include CanCan::Ability

  def initialize(user)
# Define abilities for the passed in user here. For example:

    user ||= User.new # guest user (not logged in)
    Rails.logger.info "debug:: "+ user.roles().join(",")
    if user.role? :admin
      can :manage, :all
    else
      can :read, :all
      can :create, [Post, Comment]
      can [:update, :destroy], Post do |post|
        post.try(:user) == user
      end
      can [:update, :destroy], Comment do |comment|
        comment.try(:user) == user  || user.role?(:moderator)
      end
    end
  end

end
