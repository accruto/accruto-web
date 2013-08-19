class PagesController < ApplicationController
	skip_authorization_check

  def stylesheet
  end

  def modal_apply
  end

  def modal_signup
  end

  def home
	  @categories = JobCategory.all
	  render :layout => 'home'
  end

  def about
  end

  def faq
  end

  def contact
  end
end
