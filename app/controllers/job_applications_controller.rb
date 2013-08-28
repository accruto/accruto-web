class JobApplicationsController < ApplicationController
	before_filter :authenticate_user!, only: :apply

  # GET /job_applications/1
  # GET /job_applications/1.json
  def show
    @job_application = JobApplication.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @job_application }
    end
  end

  # GET /job_applications/new
  # GET /job_applications/new.json
  def new
  	@job = Job.find(params[:job_id])
    @job_application = JobApplication.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @job_application }
    end
  end

  # GET /job_applications/1/edit
  def edit
    @job_application = JobApplication.find(params[:id])
  end

  # POST /job_applications
  # POST /job_applications.json
  def create
  	@job = Job.find(params[:job_id])
    @job_application = JobApplication.new(params[:job_application])
    @job_application.user_id = current_user.id
    @job_application.job_id = @job.id
    respond_to do |format|
      if @job_application.save
        format.html { redirect_to users_applications_path, notice: 'Congratulations. Your job application was submitted successfully.' }
        format.json { render json: @job_application, status: :created, location: @job_application }
      else
        format.html { render action: "new" }
        format.json { render json: @job_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /job_applications/1
  # PUT /job_applications/1.json
  def update
    @job_application = JobApplication.find(params[:id])

    respond_to do |format|
      if @job_application.update_attributes(params[:job_application])
        format.html { redirect_to @job_application, notice: 'Job application was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @job_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /job_applications/1
  # DELETE /job_applications/1.json
  def destroy
    @job_application = JobApplication.find(params[:id])
    @job_application.destroy

    respond_to do |format|
      format.html { redirect_to job_applications_url }
      format.json { head :no_content }
    end
  end
end
