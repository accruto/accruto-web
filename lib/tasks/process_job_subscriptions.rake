namespace 'accruto:job_subscriptions' do
  desc "Check and update subscribed jobs"
  task :process => :environment do
    User.joins(:preference).where("preferences.next_alert_date = ?", Date.today).each do |user|
      unless user.has_role? :admin
        begin
          puts "Processing user #{user.email}".green
          jobs = user.collect_jobs_results
          unless jobs.empty?
            puts "  Send mailer process to background job".green
            Delayed::Job.enqueue JobMailerWorker.new({ user: user, jobs: jobs}), :queue => 'job-alert-email'
          end
        rescue => e
          Rails.logger.info e
        end
      end
    end
  end
end