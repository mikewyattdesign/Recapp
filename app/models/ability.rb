class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/bryanrite/cancancan/wiki/Defining-Abilities
    user ||= User.new

    alias_action :create, :read, :update, :destroy, to: :crud

    alias_action :create, :read, :update, to: :cru

    can :manage, :all if user.is_super_admin?

    can :s3_upload_complete, Photo

    if user.is_admin?
        can :crud, Assignment
        can :update_role, Assignment
        can :create, User
        can :read, User
        can :update, User
        can :read, Brand
        can :cru, Program
        can :create, Event
        can :read, Event
        can :update, Event, completed_at: nil
        can :export, Event
        can :cru, Photo
        can :favorite, Photo
        can :cru, Video
        can :cru, Giveaway
        can :crud, Request
    end

    if user.is_field_staff?
        can :create, Event
        can :read, Event
        can :update, Event, completed_at: nil
        can :crud, Photo
        can :crud, Video
        can :cru, Giveaway
        can :cru, Program
    end

    if user.is_g360?
        can :read, Brand
        can :read, Program
        can :read, Event
        can :create, Photo
        can :read, Photo
        can :favorite, Photo
        can :create, Video
        can :read, Video
    end

    if user.is_client?
        can :read, Brand
        can :read, Program
        can :read, Event
        can :read, Photo
        can :read, Video
    end
  end
end
