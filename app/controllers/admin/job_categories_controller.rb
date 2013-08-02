class Admin::JobCategoriesController < ApplicationController
  # GET /job_categories
  # GET /job_categories.json
  def index
    @categories = JobCategory.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def new
    @category = JobCategory.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /job_category/1/edit
  def edit
    @category = JobCategory.find(params[:id])
  end

  # POST /job_category
  # POST /job_category.json
  def create
    @category = JobCategory.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to admin_job_category_path, notice: 'Category was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /job_categories/1
  # PUT /job_categories/1.json
  def update
    @category = JobCategory.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to admin_job_category_path, notice: 'Category was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /job_categories/1
  # DELETE /job_categories/1.json
  def destroy
    @category = JobCategory.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to admin_job_category_url }
    end
  end
end
