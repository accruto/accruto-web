class UserMailer < ActionMailer::Base
  default from: "Accruto Support <support@accruto.com>"

  def total_candidates

    mail(
      from: "Accruto Support <support@accruto.com>",
      to: "phil@pollenizer.com; dhendyf@gmail.com",
      subject: "[Accruto] Daily info total imported candidates"
    )
  end
end
