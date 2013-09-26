class ResumesController < ApplicationController
  def index
    @resumes = Resume.scoped
  end
end