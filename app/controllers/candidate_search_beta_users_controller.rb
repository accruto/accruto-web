class CandidateSearchBetaUsersController < ApplicationController
  def signup
    @user = CandidateSearchBetaUser.new(params[:candidate_search_beta_user])
    respond_to do |format|
      if @user.save
        ContactMailer.candidate_search_beta(@user).deliver
        @success_message = "Thank you for signing up for our private beta. We will be in touch within 48 hours."
        format.js
      else
        #@failure_message = "Failed to submit details. Please try again."
        @failure_message = @user.errors.full_messages.join(", ")
        format.js
      end
    end
  end
end