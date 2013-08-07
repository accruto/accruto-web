class PagesController < ApplicationController
  def stylesheet
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
