class Admin::ReferralSitesController < ApplicationController
  # GET /admin/referral_sites
  # GET /admin/referral_sites.json
  def index
    @referral_sites = ReferralSite.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @referral_sites }
    end
  end

  # GET /admin/referral_sites/1
  # GET /admin/referral_sites/1.json
  def show
    @referral_site = ReferralSite.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @referral_site }
    end
  end

  # GET /admin/referral_sites/new
  # GET /admin/referral_sites/new.json
  def new
    @referral_site = ReferralSite.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @referral_site }
    end
  end

  # GET /admin/referral_sites/1/edit
  def edit
    @referral_site = ReferralSite.find(params[:id])
  end

  # POST /admin/referral_sites
  # POST /admin/referral_sites.json
  def create
    @referral_site = ReferralSite.new(params[:referral_site])

    respond_to do |format|
      if @referral_site.save
        format.html { redirect_to admin_referral_sites_url, notice: 'Referral site was successfully created.' }
        format.json { render json: @referral_site, status: :created, location: @referral_site }
      else
        format.html { render action: "new" }
        format.json { render json: @referral_site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/referral_sites/1
  # PUT /admin/referral_sites/1.json
  def update
    @referral_site = ReferralSite.find(params[:id])

    respond_to do |format|
      if @referral_site.update_attributes(params[:referral_site])
        format.html { redirect_to admin_referral_sites_url, notice: 'Referral site was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @referral_site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/referral_sites/1
  # DELETE /admin/referral_sites/1.json
  def destroy
    @referral_site = ReferralSite.find(params[:id])
    @referral_site.destroy

    respond_to do |format|
      format.html { redirect_to admin_referral_sites_url }
      format.json { head :no_content }
    end
  end
end
