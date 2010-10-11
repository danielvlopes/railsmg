class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all

    if user.nil?
      can :create, User
      can :activate, User
    else
      if user.admin?
        can :manage, :all
      else
        can :update, User, :id => user.id
        can :update, Meeting, :user_id => user.id
      end
    end
  end
end
