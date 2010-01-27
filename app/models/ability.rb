class Ability
  include CanCan::Ability

  def initialize(current_user)
    can :read, :all
    can [:create,:activate], User

    if current_user.present? && current_user.admin?
      can :manage, :all
    else current_user.present?
      can(:update, User) { |user| current_user == user }
      can(:update, Meeting) { |meeting| meeting.try(:user) == current_user }
    end
  end
  
end
