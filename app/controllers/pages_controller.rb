class PagesController < ApplicationController
	skip_authorization_check

  def stylesheet
  end

  def modal_apply
  end

  def modal_signup
  end

  def modal_email_alert
  end

  def home
	  @categories = JobCategory.all
    @candidate_search_beta_user = CandidateSearchBetaUser.new
	  render :layout => 'home'
    set_invited_by
  end

  def about
    @contact_form = ContactForm.new
  end

  def terms
  end

  def privacy
  end

  def faq
  end

  def contact
  	@contact_form = ContactForm.new
  end

	def send_contact_form
		@contact_form = ContactForm.new(params[:contact_form])
		if @contact_form.valid?
		  ContactMailer.contact_form(@contact_form).deliver
		  redirect_to contact_path, :notice => "Message was successfully sent."
		else
		  render :contact
		end
	end

  private

  def set_invited_by
    session[:invite_email] = params[:invite_email] if params[:invite_email].present?
  end
end
