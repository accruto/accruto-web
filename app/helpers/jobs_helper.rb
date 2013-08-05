module JobsHelper
	def total_search_result
		return Job.text_search(params[:query]).length
	end
end
