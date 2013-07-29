class PagesController < ApplicationController
  def stylesheet
  end

  def home
  	@job = Job.new
  end

  def about
  end

  def faq
  end

  def contact
  end
end
