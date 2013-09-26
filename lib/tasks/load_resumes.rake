namespace 'accruto:resumes' do
  desc "Load resumes from linkme"
  task :linkme => :environment do
    link_me = LinkMe.new
    resumes = link_me.resumes
    collected_resumes = []
    resumes.each do |resume|
      affiliations  = resume['affiliations']
      awards        = resume['awards']
      citizenship   = resume['citizenship']
      courses       = resume['courses']
      interests     = resume['interests']
      objective     = resume['objective']
      other         = resume['other']
      professional  = resume['professional']
      referees      = resume['referees']
      skills        = resume['skills']
      summary       = resume['summary']
      updated_at_linkme = resume['lastEditedTime']

      print "Queueing to process: #{ summary.truncate(180) if summary }\n".yellow
      collected_resumes << Resume.new(
        affiliations: affiliations,
        awards: awards,
        citizenship: citizenship,
        courses: courses,
        interests: interests,
        objective: objective,
        other: other,
        professional: professional,
        referees: referees,
        skills: skills,
        summary: summary,
        updated_at_linkme: updated_at_linkme
      )

    end
    print " Importing Resumes\n".green
    Resume.import collected_resumes
  end
end