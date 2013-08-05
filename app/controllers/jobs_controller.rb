class JobsController < ApplicationController

  def show
    @job = Job.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @job }
    end
  end

  def search
  	#@jobs = Job.order("expires_at DESC").paginate(:page => params[:page], :per_page => 10)
  	@jobs = Job.order("expires_at DESC").text_search(params[:query]).page(params[:page]).per_page(10)

  	respond_to do |format|
  	  format.html
  	  format.json { render json: @jobs }
  	end
  end

end
