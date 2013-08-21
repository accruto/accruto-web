namespace 'accruto:job_subscriptions' do
  desc "Check and update subscribed jobs"
  task :process => :environment do
    User.job_alert_subscribed.each do |user|
      unless user.has_role? :admin
        begin
          puts "Processing user #{user.email}".green
          user.collect_jobs_results
        rescue => e
          Rails.logger.info e
        end
      end
    end
  end
end