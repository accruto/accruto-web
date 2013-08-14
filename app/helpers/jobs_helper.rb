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
end
