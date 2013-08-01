namespace :load_feed do
	desc "Seeds database with careerone jobs"
	task :career_one => :environment do
		@parsed_jobs = Job.load_careerone_feed(20)
		@parsed_jobs.each do |parsed_job|
			@job = Job.find_or_initialize_by_title(parsed_job.title)
			@company = Company.find_or_initialize_by_name(parsed_job.company.name)
			@address = Address.new

			@job.subcategories = []
			parsed_job.industries.each do |subcategory|
				job_subcategory = JobSubcategory.find_or_initialize_by_name(subcategory)
				job_subcategory.save
				@job.subcategories << job_subcategory
			end


			@company.name = parsed_job.company.name
			@company.save

			@address.city = parsed_job.company.city
			@address.postcode = parsed_job.company.postcode
			@address.postcode = parsed_job.company.postcode
			@address.state = parsed_job.company.state

			@job.title = parsed_job.title
			@job.external_job_id = parsed_job.external_job_id
			@job.source = parsed_job.source
			@job.description = parsed_job.description
			@job.posted_at = parsed_job.posted_at
			@job.expires_at = parsed_job.expires_at
			@job.job_type = parsed_job.types.join(", ")
			@job.company = @company
			@job.address = @address
			@job.save
		end
	end
end