class Admin::CandidatesController < ApplicationController
  # GET /jobs
  # GET /jobs.json
  #load_and_authorize_resource
  layout 'admin'
  load_and_authorize_resource
  def index
    @candidates = Candidate.scoped
  end

  def new
    @candidate = Candidate.new
  end

  # GET /jobs/1/edit
  def edit
    @candidate = Candidate.find(params[:id])
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @candidate = Candidate.new(params[:job])

    if @candidate.save
      redirect_to admin_jobs_path, notice: 'Job was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /jobs/1
  # PUT /jobs/1.json
  def update
    @candidate = Candidate.find(params[:id])

    if @candidate.update_attributes(params[:job])
      redirect_to admin_jobs_path, notice: 'Job was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @candidate = Candidate.find(params[:id])
    @candidate.destroy
    redirect_to admin_jobs_url
  end
end
