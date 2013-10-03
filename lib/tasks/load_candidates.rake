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

  desc "Load recent candidates from linkme"
  task :linkme => :environment do
    link_me = LinkMe.new
    candidates = link_me.recent_candidates
    #collected_candidates = []

    candidates.each do |candidate|
      print "Queueing to process: #{candidate["Email"]}\n".yellow

      ## PARSE USER
      user = parse_user(candidate)

      ## PARSE RESUME XML
      resume_xml, phone = parse_resume_xml(candidate["lensXml"]) if candidate["lensXml"]

      ## PARSE ADDRESS
      address = parse_address(resume_xml, candidate)

      ## CREATE CANDIDATE
      candidate = create_candidate(user, candidate, address, phone)

      ## PARSE EDUCATION
      education = parse_education(resume_xml, candidate) if resume_xml

      ## PARSE TRADE QUALIFICATIONS
      parse_trade_qualification(resume_xml, candidate) if resume_xml && resume_xml["skills"]

      ## PARSE EXPERIENCES
      parse_experiences(resume_xml, candidate) if resume_xml
    end
  end

  def parse_user(candidate)
    collected_user_data = {
      email: candidate["Email"],
      password: 'F2O3qi3R',
      password_confirmation: 'F2O3qi3R'
    }
    user = User.find_by_email(candidate["Email"])
    user ? user : User.create(collected_user_data)
  end

  def parse_resume_xml(candidate_lens_xml)
    resume_xml = Hash.from_xml candidate_lens_xml
    resume_xml = resume_xml["ResDoc"]["resume"]
    if resume_xml && resume_xml["contact"]
      phone = resume_xml["contact"]["phone"]
    end
    [resume_xml, phone]
  end

  def create_candidate(user, candidate, address, phone)
    begin
      name = candidate["Name"].split(" ")
      summary = candidate["summary"]
      objective = candidate["objective"]

      collected_candidate_data = {
        first_name: name.first,
        last_name: name.last,
        phone: phone,
        status: candidate["Status"],
        job_title: candidate["RecentJobTitle"],
        address_id: address.id,
        visa: Candidate::VISA[candidate["visaStatus"].to_i],
        minimum_annual_salary: candidate["Salary"],
        user_id: user.id,
        profile_photo: '',
        desired_job_title: candidate["DesiredJobTitle"] ? prepare_desired_job(candidate["DesiredJobTitle"]) : {},
        summary: summary || objective
      }
      candidate = Candidate.find_by_user_id(user.id)
      candidate ? candidate : Candidate.create(collected_candidate_data)
    rescue
    end
  end

  def parse_address(resume_xml, candidate)
    begin
      if resume_xml && resume_xml["contact"]
        street = resume_xml["contact"]["address"]["street"]
        city = resume_xml["contact"]["address"]["city"] || candidate["address_city"]
        postalcode = resume_xml["contact"]["address"]["postalcode"]
        state = resume_xml["contact"]["address"]["state"] || candidate["address_state"]
        latitude = resume_xml["contact"]["address"]["lat"] || candidate["address_latitude"]
        longitude = resume_xml["contact"]["address"]["lon"] || candidate["address_longitude"]

        collected_address_data = {
          street: street,
          city: city,
          postcode: postalcode,
          state: state,
          latitude: latitude,
          longitude: longitude
        }
      else
        collected_address_data = {
          street: '',
          city: candidate["address_city"],
          postcode: '',
          state: candidate["address_state"],
          latitude: candidate["address_latitude"],
          longitude: candidate["address_longitude"]
        }
      end
      Address.create(collected_address_data)
    rescue
    end
  end

  def parse_education(resume_xml, candidate)
    begin
      collected_education_data = nil
      resume_xml["education"].each do |education|
        if education.is_a?(Hash)
          education["school"].each do |school|
            if school[0]
              # handle weird Array
              case school[0]
                when "institution"
                  institution = school[1]
                when "degree"
                  qualification = school[1]
                  qualification_type = parse_education_degree(school[1])
                when "major"
                  qualification_major = school[1]
                when "daterange"
                  start_at = education_date_range(school[1]['end']) if school[1]['start']
                  graduated_at = education_date_range(school[1]['end']) if school[1]['end']
              end
            else
              # handle Hash
              institution = school['institution']
              qualification = school['degree']
              qualification_type = parse_education_degree(school['degree'])
              qualification_major = school['major']
              if school['daterange']
                start_at = education_date_range(school['daterange']['end']) if school['daterange']['start']
                graduated_at = education_date_range(school['daterange']['end']) if school['daterange']['end']
              end
            end

            collected_education_data = {
              institution: institution,
              qualification: qualification,
              qualification_type: qualification_type,
              qualification_major: qualification_major,
              start_at: start_at,
              graduated_at: graduated_at,
              candidate_id: (candidate['id'] if candidate)
            }
            Education.create(collected_education_data)
          end if education['school']
        elsif education[0] == 'school'
          school = education[1]
          if school.is_a?(Array)
            school.each do |school|
              institution = school['institution']
              qualification = school['degree']
              qualification_type = parse_education_degree(school['degree'])
              qualification_major = school['major']
              if school['daterange']
                start_at = education_date_range(school['daterange']['end']) if school['daterange']['start']
                graduated_at = education_date_range(school['daterange']['end']) if school['daterange']['end']
              end
            end
          else
            institution = school['institution']
            qualification = school['degree']
            qualification_type = parse_education_degree(school['degree'])
            qualification_major = school['major']
            if school['daterange']
              start_at = education_date_range(school['daterange']['end']) if school['daterange']['start']
              graduated_at = education_date_range(school['daterange']['end']) if school['daterange']['end']
            end
          end

          collected_education_data = {
            institution: institution,
            qualification: qualification,
            qualification_type: qualification_type,
            qualification_major: qualification_major,
            start_at: start_at,
            graduated_at: graduated_at,
            candidate_id: (candidate['id'] if candidate)
          }

          Education.create(collected_education_data)
        end
      end
      #Education.create(collected_education_data) if collected_education_data
    rescue
    end
  end

  def parse_trade_qualification(resume_xml, candidate)
    begin
      trade_qualifications = resume_xml["skills"].split("\n")
      trade_qualifications.each { |t| t.gsub('\t','').strip }
      trade_qualifications.delete_if {|t| t.empty? }
      trade_qualifications.delete_if {|t| t.downcase.include?("skill") }
      trade_qualifications.each do |tr|
        TradeQualification.create(name: tr.strip, candidate_id: candidate.id)
      end
    rescue
    end
  end

  def parse_experiences(resume_xml, candidate)
    begin
      resume_xml["experience"]["job"].each do |job|
        if job.is_a?(Hash)
          started_at, ended_at = nil, nil
          if job["daterange"]
            started_at = education_date_range(job["daterange"]["start"])
            ended_at = if job["daterange"]["end"] == "current"
               Time.now
             else
               education_date_range(job["daterange"]["end"])
             end
            current_job = true if job["daterange"]["end"] == "current"
          end
          collected_user_data = {
            job_title: job["title"],
            description: job["description"],
            company: job["employer"],
            started_at: started_at,
            ended_at: ended_at,
            current: job["pos"] == "0" || current_job ? true : false,
            candidate_id: candidate.id
          }
          Experience.create(collected_user_data)
        end
      end
    rescue
    end
  end

  def parse_education_degree(degree)
    ### EDUCATION LEVEL: Doctorate Masters Degree Bachelor Diploma Certificate School
    if degree.include?("Doctor")
      "Doctorate"
    elsif degree.include?("Master")
      "Master"
    elsif degree.include?("Degree")
      "Degree"
    elsif degree.include?("Dip")
      "Diploma"
    elsif degree.include?("Cert") || degree.include?("HSC")
      "Certificate"
    elsif degree.include?("School")
      "School"
    elsif degree.include?("Bachelor")
      "Bachelor"
    end
  end

  def prepare_desired_job(jobs)
    desired_jobs = {}
    jobs.split(",").each_with_index { |x, idx| desired_jobs[idx] = x.strip }
    desired_jobs
  end

  def education_date_range(time)
    date = time.split(" ")
    if date.size == 1
      Time.new(date[0])
    elsif date.size == 2
      month = Date::MONTHNAMES.index(date[0]) ## Date::ABBR_MONTHNAMES.index("Jun")
      year = date[1].to_i
      Time.new(year, month)
    end
  end

  def is_number?
    self.to_f.to_s == self.to_s || self.to_i.to_s == self.to_s
  end
end