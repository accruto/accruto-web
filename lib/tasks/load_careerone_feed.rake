namespace :load_careerone_feed do
	desc "Seeds database with careerone jobs"
	task :all => :environment do
		i = 1
		total_jobs = Job.all.length
		JobSubcategory.all.each do |subcategory|
			@loaded_jobs = Job.load_careerone_feed(subcategory.external_subcategory_id)
			unless @loaded_jobs.blank?
				@loaded_jobs.each_with_index do |job, index|
					@job = Job.find_or_initialize_by_external_job_id(job.external_job_id)
					@company = Company.find_or_initialize_by_name(job.company.name)
					@address = Address.find_or_initialize_by_city(job.city)

					@job.subcategories = []
					job.industries.each do |sc|
						job_subcategory = JobSubcategory.find_or_initialize_by_name(sc)
						job_subcategory.save
						@job.subcategories << job_subcategory
					end

					@company.name = job.company.name
					@company.save

					@address.city = job.city
					@address.postcode = job.postcode
					@address.state = job.state

					@job.title = job.title
					puts "#{i} - #{@job.title}"
					i += 1

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
		puts "Total Jobs From Feed: #{i}"
		new_total_jobs = Job.all.length
		new_jobs_added = new_total_jobs - total_jobs
		puts "Total New Jobs Added: #{new_jobs_added}"
		puts "Total Jobs in DB: #{new_total_jobs}"
	end
end