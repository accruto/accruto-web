class JobsController < ApplicationController
	def new
		@job = Job.new
		@job.build_company
		@job.build_address
		@job.subcategories.build
		@subcategories = JobSubcategory.all
	end

	def create
		@job = Job.new(params[:job])
		if @job.save
			redirect_to root_path, notice: "Job was succesfully posted"
		else
			render action: "new"
		end
	end

  def show
    @job = Job.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @job }
    end
  end

  def search
  	@search_results = Job.search_by_job_title(params[:job_title].downcase)
									  	.search_by_address(params[:address].downcase)
									  	.filter_by_days(params[:days])

  	@jobs = @search_results.page(params[:page]).per_page(10)

  	respond_to do |format|
  	  format.html
  	  format.json { render json: @jobs }
  	end
  end

end
