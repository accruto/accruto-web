namespace 'accruto:candidates' do
  desc "Seed database with candidates"
  task :seed => :environment do
    200.times do
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      job_title = Faker::Job.title
      Candidate.create(
        first_name: first_name,
        last_name: last_name,
        job_title: job_title,
        status: "Actively Looking",
        visa: "Valid work visa",
        minimum_annual_salary: 50000,
        address_id: 45412
      )
      print "Added candidate: #{first_name} #{last_name}, ".yellow + "#{job_title}\n".green
    end
  end
end