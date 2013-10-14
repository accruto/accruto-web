class Admin::BountiesController < ApplicationController
  # GET /admin/bounties
  # GET /admin/bounties.json
  layout 'admin'
  load_and_authorize_resource
  def index
    @bounties = Bounty.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bounties }
    end
  end

  # GET /admin/bounties/1
  # GET /admin/bounties/1.json
  def show
    @bounty = Bounty.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bounty }
    end
  end

  # GET /admin/bounties/new
  # GET /admin/bounties/new.json
  def new
    @bounty = Bounty.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bounty }
    end
  end

  # GET /admin/bounties/1/edit
  def edit
    @bounty = Bounty.find(params[:id])
  end

  # POST /admin/bounties
  # POST /admin/bounties.json
  def create
    @bounty = Bounty.new(params[:bounty])

    respond_to do |format|
      if @bounty.save
        format.html { redirect_to admin_bounties_path, notice: 'Bounty was successfully created.' }
        format.json { render json: @bounty, status: :created, location: @bounty }
      else
        format.html { render action: "new" }
        format.json { render json: @bounty.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/bounties/1
  # PUT /admin/bounties/1.json
  def update
    @bounty = Bounty.find(params[:id])

    respond_to do |format|
      if @bounty.update_attributes(params[:bounty])
        format.html { redirect_to admin_bounties_path, notice: 'Bounty was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bounty.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/bounties/1
  # DELETE /admin/bounties/1.json
  def destroy
    @bounty = Bounty.find(params[:id])
    @bounty.destroy

    respond_to do |format|
      format.html { redirect_to bounties_url }
      format.json { head :no_content }
    end
  end
end
