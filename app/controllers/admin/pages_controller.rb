class Admin::PagesController < ApplicationController
  layout 'admin'
  before_filter :verify_admin

  def dashboard
    @recent_candidates = Candidate.limit(10)
    @recent_invites = Invite.limit(10)
  end
end