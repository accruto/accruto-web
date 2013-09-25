module PagesHelper
	def date_filter_options
		return [
			["All", nil],
			["Today", 1],
			["Last 3 days", 3],
			["Last 7 days", 7],
			["Last 14 days", 14],
			["Last 30 days", 30]
		]
	end

	def sort_filter_options
		return [
			["Relevance", 'relevance'],
			["Date Posted", 'posted_at']
		]
	end

	def hidden_on_desktop_page(page)
		if params[:action] == page
			return 'hidden-desktop'
		end
	end
end
