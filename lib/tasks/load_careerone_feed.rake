namespace :load_careerone_feed do
	desc "Seeds database with careerone jobs"
	task :accounting => :environment do
		@loaded_jobs = Job.load_careerone_feed(1, 20)
		@loaded_jobs.each do |job|
			@job = Job.find_or_initialize_by_title(job.title)
			@company = Company.find_or_initialize_by_name(job.company.name)
			@address = Address.new

			# @job.subcategories = []
			# job.industries.each do |subcategory|
			# 	job_subcategory = JobSubcategory.find_or_initialize_by_name(subcategory)
			# 	job_subcategory.save
			# 	@job.subcategories << job_subcategory
			# end


			@company.name = job.company.name
			@company.save

			@address.city = job.company.city
			@address.postcode = job.company.postcode
			@address.state = job.company.state

			@job.title = job.title
			@job.external_job_id = job.external_job_id
			@job.source = job.source
			@job.description = job.description
			@job.posted_at = job.posted_at
			@job.expires_at = job.expires_at
			@job.job_type = job.types.join(", ")
			@job.company = @company
			@job.address = @address
			@job.save
		end
	end

	task :all => :environment do
		JobCategory.all.each do |category|
			@loaded_jobs = Job.load_careerone_feed(category.external_category_id, 20)
			@loaded_jobs.each do |job|
				@job = Job.find_or_initialize_by_title(job.title)
				@company = Company.find_or_initialize_by_name(job.company.name)
				@address = Address.new

				# @job.subcategories = []
				# job.industries.each do |subcategory|
				# 	job_subcategory = JobSubcategory.find_or_initialize_by_name(subcategory)
				# 	job_subcategory.save
				# 	@job.subcategories << job_subcategory
				# end


				@company.name = job.company.name
				@company.save

				@address.city = job.company.city
				@address.postcode = job.company.postcode
				@address.state = job.company.state

				@job.title = job.title
				@job.external_job_id = job.external_job_id
				@job.source = job.source
				@job.description = job.description
				@job.posted_at = job.posted_at
				@job.expires_at = job.expires_at
				@job.job_type = job.types.join(", ")
				@job.company = @company
				@job.address = @address
				@job.save
			end
		end
	end
end