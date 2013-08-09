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
	unless params[:category]
		@search_results = Job.search_by_job_title(params[:job_title])
						  	.filter_by_address(params[:address])
						  	.filter_by_days(params[:days])
						  	.sort_by(params[:sort])
						  	.active
		@jobs = @search_results.page(params[:page]).per_page(10)
	else
		@subcategories = JobCategory.where(slug: params[:category]).first.subcategories
		#@search_results = @subcategories.map { |sc| sc.jobs }.first
		@search_results = @subcategories.map { |sc| sc.jobs }.flatten
		@jobs = @search_results.paginate(page: params[:page], per_page: 10)
	end
		respond_to do |format|
		  format.html
		  format.json { render json: @jobs }
		end
  end

end
