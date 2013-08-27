namespace 'accruto:feed:jobadder' do
  desc "Parse jobadder job feed"
  task :parse => :environment do

    ## Get XML from remote uri
    remote_xml = GetRemoteXML.new(url: 'https://feeds.jobadder.com/jobs/all',
                                  username: 'linkme',
                                  password: 'pe5redef')
    doc = remote_xml.send_request

    ## Parse returned XML
    parser = JobParser::Jobadder.new(doc)
    parser.run
  end
end