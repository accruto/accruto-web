class ContactMailer < ActionMailer::Base
  default from: "Accruto Contact Form <support@accruto.com>"

  def contact_form(contact_form)
    @contact_form = contact_form

    mail(
      to: 'john@accruto.com',
      subject: "A new contact form entry was created"
    )
  end

  def test_email
    mail(
        to: 'dhendyf@gmail.com',
        subject: 'DEBUG EMAIL SUBJECT',
        body: '<h3>DEBUG EMAIL</h3>'
    )
  end
end
