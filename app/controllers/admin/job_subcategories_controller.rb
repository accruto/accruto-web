class Admin::JobSubcategoriesController < ApplicationController
  # GET /job_categories
  # GET /job_categories.json
  load_and_authorize_resource

  def index
    @subcategories = JobSubcategory.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def new
    @subcategory = JobSubcategory.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /job_subcategory/1/edit
  def edit
    @subcategory = JobSubcategory.find(params[:id])
  end

  # POST /job_subcategory
  # POST /job_subcategory.json
  def create
    @subcategory = JobSubcategory.new(params[:subcategory])

    respond_to do |format|
      if @category.save
        format.html { redirect_to admin_job_subcategory_path, notice: 'Subcategory was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /job_categories/1
  # PUT /job_categories/1.json
  def update
    @subcategory = JobSubcategory.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:subcategory])
        format.html { redirect_to admin_job_subcategory_path, notice: 'Subcategory was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /job_categories/1
  # DELETE /job_categories/1.json
  def destroy
    @subcategory = JobSubcategory.find(params[:id])
    @subcategory.destroy

    respond_to do |format|
      format.html { redirect_to admin_job_subcategory_url }
    end
  end
end
