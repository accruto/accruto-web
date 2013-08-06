class JobsController < ApplicationController

  def show
    @job = Job.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @job }
    end
  end

  def search
  	@search_results = Job.search_by_job_title(params[:job_title]).search_by_address(params[:address])
  	@jobs = @search_results.page(params[:page]).per_page(10)

  	respond_to do |format|
  	  format.html
  	  format.json { render json: @jobs }
  	end
  end

end
