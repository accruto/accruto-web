class ShortlistsController < ApplicationController
  def index
  end

  def start
  end

  def create
    begin
      shortlist = current_user.shortlists.create!(candidate_id: params[:candidate_id])
      response = true
    rescue
      shortlist = nil
      response = false
    end
    render json: {success: response, shortlist: shortlist}
  end

  def destroy
    shortlist = Shortlist.find(params[:shortlist_id])
    candidate_id = shortlist.candidate_id
    response = shortlist.delete ? true : false
    render json: {success: response, candidate_id: candidate_id}
  end
end