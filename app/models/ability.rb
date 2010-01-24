class Ability
  include CanCan::Ability

  def initialize(current_user)

    if current_user.nil?
      can :read, :all
      can :create, User
    elsif current_user.admin?
      can :manage, :all
    else
      can :update, User {|user| user == current_user }
    end

  end
end