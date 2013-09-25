namespace 'accruto:candidates' do
  desc "Seed database with candidates"
  task :seed => :environment do
    200.times do
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      email = "#{first_name}.#{last_name}@example.com"
      job_title = Faker::Job.title
      salary = [30000, 40000, 50000, 60000, 70000, 80000, 90000].sample
      status = Candidate::STATUS.sample
      visa = Candidate::VISA.sample
      address = Address.all.sample
      phone = ["0410888888", "0410111111", nil].sample
      updated_at = [3.days.ago, 30.days.ago, 1.day.ago, 10.minutes.ago, 1.minute.ago, 5.months.ago, 1.year.ago].sample

      user = User.create(
        email: email,
        password: 'password'
      )

      Candidate.create(
        first_name: first_name,
        last_name: last_name,
        job_title: job_title,
        status: status,
        visa: visa,
        minimum_annual_salary: salary,
        address_id: address.id,
        user_id: user.id,
        phone: phone,
        updated_at: updated_at
      )
      print "Added candidate: #{first_name} #{last_name}\n".yellow
      print " Job title: #{job_title}\n".green
      print " Email address: #{email}\n".green
      print " Salary: #{salary}\n".green
      print " Status: #{status}\n".green
      print " Visa: #{visa}\n".green
      print " City: #{address.city}\n".green
      print " Phone: #{phone}\n".green
      print " Updated at: #{updated_at}\n".green
      print "-----\n"
    end
  end
end