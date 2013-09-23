class CandidatesController < ApplicationController
  layout 'search_results', only: [:search, :show]

  def index
    @candidates = Candidate.scoped.paginate(page: params[:page], per_page: 10)
  end
end