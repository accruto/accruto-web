class ContactMailer < ActionMailer::Base
  default from: "Accruto Contact Form <support@accruto.com>"

  def contact_form(contact_form)
    @contact_form = contact_form

    mail(
      to: 'john@accruto.com',
      subject: "A new contact form entry was created"
    )
  end

  def candidate_search_beta(user)
    @user = user

    mail(
      to: 'john@accruto.com',
      subject: "A beta signup for candidate search has been submitted"
    )
  end
end
