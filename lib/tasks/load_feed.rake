namespace :load_feed do
	desc "Seeds database with initial retailers"
	task :career_one => :environment do
		xml = File.read('careerone-feed.xml')
		jobs = JSON.parse Hash.from_xml(xml).to_json
		jobs.each do |job|
			puts job['Job']['JobTitle']
		end
	end
end