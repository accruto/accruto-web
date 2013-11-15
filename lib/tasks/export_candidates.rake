namespace 'accruto:candidates' do
  desc "export candidate csv"
  task :export => :environment do
    require 'csv'

    start_processing_time = Time.now
    print "Querying for candidates..."
    candidates = Candidate.scoped
    file = "#{Rails.root}/candidates_#{DateTime.now}.csv"

    CSV.open( file, 'w', headers: true ) do |writer|
      candidates.each do |c|
        next unless c.experiences.present? and c.educations.present? and c.address.present?
        candidate_attributes = [
          c.first_name,
          c.last_name,
          c.email,
          c.phone,
          c.job_title,
          c.status,
          c.visa,
          c.address.street,
          c.address.city,
          c.address.state,
          c.experiences[0].company,
          c.experiences[0].job_title,
          c.experiences[0].started_at,
          c.experiences[0].ended_at,
          c.educations[0].institution,
          c.educations[0].qualification,
          c.educations[0].graduated_at,
        ]
        print "Exported #{c.email}\n"
        writer << candidate_attributes
      end
      print "Exported all candidates in #{Time.now - start_processing_time} seconds \n".yellow
    end
  end
end