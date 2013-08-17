namespace 'accruto:job_subscriptions' do
  desc "Check and update subscribed jobs"
  task :process => :environment do
    User.all.each do |user|
      unless user.has_role? :admin
        begin
          jobs = user.collect_jobs_results
          unless jobs.empty?
            Delayed::Job.enqueue JobMailerWorker.new({ user: user, jobs: jobs}), :queue => 'job-alert-email'
          end
        rescue => e
          Rails.logger.info e
        end
      end
    end
  end
end