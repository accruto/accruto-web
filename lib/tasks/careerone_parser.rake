namespace 'accruto:feed:careerone' do
  desc "Parse Careerone job feed"
  task :parse => :environment do
    ## Parse returned XML
    parser = JobParser::Careerone.new
    parser.run
  end
end