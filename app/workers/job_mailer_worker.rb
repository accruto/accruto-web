class JobMailerWorker < Struct.new(:args)

  def perform
    JobMailer.notification(args[:user], args[:jobs]).deliver
  end

  def success(job)
    handler = parse_handler(job)
    user = handler[:user]
    # user.update_job_results(true)
  end

  def error(job, exception)
    handler = parse_handler(job)
    user = handler[:user]
    user.update_job_results(false)
    Rails.logger.info job.last_error
  end

  private

  def parse_handler(job)
    handler = YAML::load(job.handler)
    handler[:args]
  end
end