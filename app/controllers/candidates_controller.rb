class CandidatesController < ApplicationController
  layout 'search_results', only: [:search, :show]

  def search
    if params[:job_title].present?
      @candidates = Candidate.search_by_job_title(params[:job_title]).paginate(page: params[:page], per_page: 10)
    else
      @candidates = Candidate.scoped.paginate(page: params[:page], per_page: 10)
    end
  end
end