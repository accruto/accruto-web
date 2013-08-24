namespace 'accruto:referral' do
  desc "Load initial referral sites with access key"
  task :load => :environment do
    services = %w( Trovit Jobrapido Jooble Medepage Indeed )
    services.each do |service|
      ReferralSite.create(name: service)
    end
  end
end