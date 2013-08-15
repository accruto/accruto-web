module JobsHelper
	def total_search_result(search_results)
		return search_results.length
	end

	def total_jobs
		return Job.count
	end

	def number_of_jobs_in_category(category)
		return "(#{category.subcategories.map { |s| s.jobs.count }.inject(:+)})" if Rails.env.development?
  end

  def selected_job_favourite(job)
    if current_user && current_user.favourite_job?(job.id)
      "favourite-job"
    end
  end

  def build_search_params(recent_search)
    search_jobs_url(job_title: recent_search.job_title, address: recent_search.address, days: recent_search.days,
                    sort: recent_search.sort, category: recent_search.category)
  end
end
