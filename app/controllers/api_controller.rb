class ApiController < ApplicationController
  before_filter :restrict_access
  skip_before_filter :verify_authenticity_token

  def jobs
    @jobs = if params[:source].present?
      Job.where("LOWER(source) = LOWER(?)", params[:source])
    elsif params[:category].present?
      Job.joins(:subcategories => :category).where("LOWER(job_categories.name) = LOWER(?)", params[:category])
    elsif params[:subcategory].present?
      Job.joins(:subcategories => :category).where("LOWER(job_subcategories.name) = LOWER(?)", params[:subcategory])
    elsif params[:posted_after].present?
      Job.where("DATE(posted_at) > ?", params[:posted_after])
    else
      Job.scoped
    end

    @jobs = if params[:limit].present?
      @jobs.limit(params[:limit].to_i)
    end

    referral_site = ReferralSite.find_by_token(params[:token])
    name = referral_site.name.downcase

    respond_to do |format|
      format.xml { render template: "api/#{name}.xml"}
      # format.xml do
      #   stream = render_to_string(:template => "api/#{name}.xml" )
      #   send_data(stream, :type=>"text/xml",:filename => "accruto_feed_#{Date.today.to_s(:db)}.xml")
      # end
    end
  end

  private

  def restrict_access
    api_key = ReferralSite.find_by_token(params[:token])
    head :unauthorized unless api_key
  end

end