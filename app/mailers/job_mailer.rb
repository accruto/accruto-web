class JobMailer < ActionMailer::Base
  default from: "Accruto Job Alert <alert@accruto.com>"

  def notification(user, jobs)
    @user, @jobs = user, jobs

    mail(
      to: @user.email,
      subject: "#{jobs.size} new jobs"
    )
  end
end
