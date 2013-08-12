class Ability
  include CanCan::Ability

  def initialize(user)
    if user && user.has_role?(:admin)
      can :manage, [Job, Company, JobCategory, JobSubcategory, User, Role]
    end
  end
end
