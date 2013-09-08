class Ability
  include CanCan::Ability

  def initialize(user)
# Define abilities for the passed in user here. For example:

    user ||= User.new # guest user (not logged in)
#    Rails.logger.info "debug:: "+ user.role
    if user.role == "admin"
      can :manage, :all
    elseif user.role == "banned"
      can :read, :all
    else
      can :read, :all
      can :vote_up, :all
      can :vote_down, :all
      can :manage, Post, :user_id => user.id
      can :manage, Comment, :user_id => user.id
   
#      can :create, [Post, Comment]
#      can :vote_up, [Post, Comment]
#      can :vote_down, [Post, Comment]
#      can [:update, :destroy], Post do |post|
#        post.try(:user) == user
#      end
#      can [:update, :destroy], Comment do |comment|
#        comment.try(:user) == user  #|| user.role?(:moderator)
#      end
    end
  end

end
