class Ability
  include CanCan::Ability

  def initialize(user)
    if user && user.has_role?(:admin)
      can :manage, [Job, Company, JobCategory, JobSubcategory, User, Role, Candidate, ReferralSite, Bounty]
    end
  end
end
