class PagesController < ApplicationController
  def stylesheet
  end

  def home
  	@job = Job.new
  	@jobs = Job.all
  end

  def about
  end

  def faq
  end

  def contact
  end
end
