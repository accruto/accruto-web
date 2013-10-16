class Admin::PagesController < ApplicationController
  layout 'admin'
  before_filter :verify_admin

  def dashboard
    @recent_candidates = Candidate.order("created_at DESC").limit(10)
    @recent_active_candidates = Candidate.where(state: "publish").order("created_at DESC").limit(10)
    @recent_invites = Invite.order("created_at DESC").limit(10)
  end
end