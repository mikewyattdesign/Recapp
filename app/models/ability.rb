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
    
    can :manage, :all if user.is_admin?

    can :s3_upload_complete, Photo

    if user.is_manager?
        can :crud, Assignment
        can :update_role, Assignment
        can :crud, User
        can :read, Brand
        can :create, Program
        can :read, Program
        can :update, Program
        can :create, Event
        can :read, Event
        can :update, Event
        can :export, Event
        can :crud, Photo
        can :crud, Video
        can :create, Giveaway
        can :read, Giveaway
        can :update, Giveaway   
    end
    
    if user.is_field_staff?
        can :create, Event
        can :read, Event
        can :update, Event
        can :crud, Photo
        can :crud, Video
        can :create, Giveaway
        can :read, Giveaway
        can :update, Giveaway
    end
  end
end
