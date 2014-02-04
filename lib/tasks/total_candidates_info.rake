namespace 'accruto:candidates' do
  desc "Email total candidates info"
  task :total => :environment do
    UserMailer.total_candidates.deliver
  end
end