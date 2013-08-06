module JobsHelper
	def total_search_result
		return @search_results.length
	end

	def total_jobs
		return Job.all.length
	end

	def number_of_jobs_in_category(category)
		return "(#{category.subcategories.map { |s| s.jobs.length }.inject(:+)})" if Rails.env.development?
	end
end
