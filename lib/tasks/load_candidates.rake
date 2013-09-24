namespace 'accruto:candidates' do
  desc "Seed database with candidates"
  task :seed => :environment do
    200.times do
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      job_title = Faker::Job.title
      salary = [30000, 40000, 50000, 60000, 70000, 80000, 90000].sample
      status = Candidate::STATUS.sample
      visa = Candidate::VISA.sample
      address = Address.all.sample

      Candidate.create(
        first_name: first_name,
        last_name: last_name,
        job_title: job_title,
        status: status,
        visa: visa,
        minimum_annual_salary: salary,
        address_id: address.id
      )
      print "Added candidate: #{first_name} #{last_name}\n".yellow
      print " Job title: #{job_title}\n".green
      print " Salary: #{salary}\n".green
      print " Status: #{status}\n".green
      print " Visa: #{visa}\n".green
      print " City: #{address.city}\n".green
      print "-----\n"
    end
  end
end