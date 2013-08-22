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
	  render :layout => 'home'
  end

  def about
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
end
