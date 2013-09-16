class ContactMailer < ActionMailer::Base
  default from: "Accruto Contact Form <support@accruto.com>"

  def contact_form(contact_form)
    @contact_form = contact_form

    mail(
      to: 'john@accruto.com',
      subject: "[Contact Form] New Submission"
    )
  end

  def candidate_search_beta(user)
    @user = user

    mail(
      to: 'john@accruto.com',
      subject: "[Candidate Search Beta] New Signup"
    )
  end
end
