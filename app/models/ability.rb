class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.persisted?
      alias_action :create, :read, :update, :destroy, to: :crud

      can :manage, :all if user.role == "admin"

      can :create_nested_resource, User, id: user.id
      can :crud, User, id: user.id
      can :crud, Album, user_id: user.id
      can :crud, Photo, album: { user_id: user.id }
      can [:create, :destroy], Comment, photo: { album: { user_id: user.id } }
      can [:create, :destroy], Comment, user_id: user.id
      can [:create, :destroy], Interrelationship, follower_id: user.id
      cannot :create, Interrelationship, { followed_id: user.id, follower_id: user.id }

      can [:read], User
      can [:read], Album
      can [:read], Photo
      can [:read], Tag
      can [:read], Comment
    end
  end
end
