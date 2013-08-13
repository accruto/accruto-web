class Admin::JobsController < ApplicationController
  # GET /jobs
  # GET /jobs.json
  load_and_authorize_resource

  def index
    @jobs = Job.limit('100')
  end

  def new
    @job = Job.new
    @job.build_company
    @job.build_address
    @job.subcategories.build
  end

  # GET /jobs/1/edit
  def edit
    @job = Job.find(params[:id])
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(params[:job])

		if @job.save
			redirect_to admin_jobs_path, notice: 'Job was successfully created.'
		else
			render action: "new"
		end
  end

  # PUT /jobs/1
  # PUT /jobs/1.json
  def update
    @job = Job.find(params[:id])

    if @job.update_attributes(params[:job])
      redirect_to admin_jobs_path, notice: 'Job was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    redirect_to admin_jobs_url
  end
end
