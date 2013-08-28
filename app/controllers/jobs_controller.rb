class JobsController < ApplicationController
  before_filter :load_favourite_jobs, only: [:show, :search, :favourites]
  layout 'search_results', only: [:search, :show]

  def index
    redirect_to root_path
  end

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
      @search_results = Job.search_by_job_title(params[:job_title]).filter_by_address(params[:address]).filter_by_days(params[:days]).sort_by(params[:sort]).active
      @jobs = @search_results.page(params[:page]).per_page(10)
    else
      @subcategories = JobCategory.where(slug: params[:category]).first.subcategories
      @search_results = @subcategories.map { |sc| sc.jobs }.flatten
      @jobs = @search_results.paginate(page: params[:page], per_page: 10)
    end

    if current_user
      handle_member_recent_searches
    else
      handle_guest_recent_searches
    end

    respond_to do |format|
      format.html
      format.json { render json: @jobs }
    end
  end

  def clear_searches
    if current_user
      RecentSearch.destroy_all "user_id = #{current_user.id}"
    else
      session[:recent_searches].clear
    end

    respond_to do |format|
      format.js
    end
  end

  def add_to_favourite
    @job = Job.find(params[:job_id])
    @job_id = @job.id
    @set_selected = true

    if !current_user.favourite_job?(@job_id)
      current_user.favourites.build(:user_id => current_user.id, :job_id => @job_id)
      current_user.save
    elsif current_user && current_user.favourite_job?(@job_id)
      current_user.favourites.find_by_job_id(@job_id).delete
      @set_selected = false
    end

    respond_to do |format|
      format.js
    end
  end

  def favourites
    @jobs = @favourite_jobs.paginate(page: params[:page], per_page: 10)

    respond_to do |format|
      format.html
    end
  end

  def remove_favourite
    @job = Job.find(params[:job_id])
    current_user.favourites.find_by_job_id(@job.id).try(:delete)

    respond_to do |format|
      format.js
    end
  end

  def clear_favourites
    current_user.favourites.delete_all

    respond_to do |format|
      format.js
    end
  end

  def set_job_alert
    @recent_search = RecentSearch.find(params[:id])
    @search_results = Job.grab_search_results(@recent_search)
    search_job_ids = @search_results.map(&:id)

    if @recent_search.subscribed
      @recent_search.inactivate_alert
    else
      @recent_search.activate_alert(search_job_ids)
    end

    respond_to do |format|
      format.js
    end
  end

  def list
    results = JobCategory.all.map {|c| [c.id, c.name] } + JobSubcategory.all.map {|sc| [sc.id, sc.name]}
    compose_json = []
    results.each do |result|
      compose_json << {:id => result[0], :label => result[1] }
    end
    respond_to do |format|
      format.json { render json: compose_json }
    end
  end

  def location
    addresses = Address.all
    results = addresses.map {|sc| [sc.city, sc.city, 0, 0]} +
              addresses.map {|sc| [sc.state, sc.state, 0, 0]}.uniq +
              addresses.map {|sc| [sc.city, sc.state, sc.state, 'merged']}
    compose_json = []
    results.each do |result|
      compose_json << {:id => result[0], :value => result[0], :label => result[1], :state => result[2], :merged => 'merged' }
    end
    respond_to do |format|
      format.json { render json: compose_json }
    end
  end

  private

  def load_favourite_jobs
    @favourite_jobs = current_user ? current_user.favourite_jobs : []
  end

  def handle_member_recent_searches
    session[:recent_searches] = nil if session[:recent_searches].present?
    existing_search = RecentSearch.where(job_title: params[:job_title], address: params[:address], user_id: current_user.id).first

    param_struct = OpenStruct.new(params)
    source = param_struct.marshal_dump
    search_filter = {job_title: params[:job_title], address: params[:address], days: params[:days], sort: params[:sort],
                     category: params[:category], search_at: Time.now, source: source}

    if (params[:job_title].present? || params[:address].present?)
      if existing_search && !existing_search.source.diff(source).empty?
        existing_search.update_attributes(search_filter)
      elsif existing_search.nil?
        RecentSearch.create(search_filter.merge(user_id: current_user.id))
      elsif existing_search
        existing_search.update_attribute(:updated_at, Time.now)
      end
    end
    @recent_searches = current_user.recent_searches.order("updated_at DESC")
  end

  def handle_guest_recent_searches
    session[:recent_searches] = [] if session[:recent_searches].nil?

    param_struct = OpenStruct.new(params)
    source = param_struct.marshal_dump
    search_filter = {job_title: params[:job_title], address: params[:address], days: params[:days], sort: params[:sort],
                     category: params[:category], search_at: Time.now, source: source}

    existing_search = session[:recent_searches].select { |search| search.job_title == params[:job_title] && search.address == params[:address] }

    if (params[:job_title].present? || params[:address].present?)
      if !existing_search.empty? && !existing_search.first.source.diff(source).empty?
        updates.each do |key, value|
          eval("existing_search.first.#{key.to_s} = '#{params[key]}'")
        end
        existing_search.first.updated_at = Time.now
      elsif existing_search.empty?
        session[:recent_searches] << OpenStruct.new(search_filter.merge(updated_at: Time.now))
      elsif !existing_search.empty?
        existing_search.first.updated_at = Time.now
      end
    end
    @recent_searches = session[:recent_searches] ? session[:recent_searches].sort_by(&:updated_at).reverse! : []
  end
end
