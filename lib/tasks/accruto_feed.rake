namespace 'accruto:feed' do

  namespace :careerone do
    desc "Parse Careerone job feed"
    task :parse => :environment do
      parser = JobParser::Careerone.new
      parser.run
    end
  end

  namespace :jobadder do
    desc "Parse jobadder job feed"
    task :parse => :environment do
      remote_xml = GetRemoteXML.new(url: 'https://feeds.jobadder.com/jobs/all',
                                    username: 'linkme',
                                    password: 'pe5redef')
      doc = remote_xml.send_request

      parser = JobParser::Jobadder.new(doc)
      parser.run
    end
  end

  namespace :medepage do
    desc "Parse Medepage job feed"
    task :parse => :environment do
      parser = JobParser::Medepage.new
      parser.run
    end
  end
end