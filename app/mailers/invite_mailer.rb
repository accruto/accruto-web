class InviteMailer < ActionMailer::Base
  default from: "info@accruto.com"

  def invite_friend(invite, user)
    @invite = invite
    @user = user
    @candidate = user.candidate

    mail(
      from: "#{@candidate.full_name} <#{@user.email}>",
      to: "#{@invite.name} <#{@invite.email}>",
      subject: "#{@candidate.full_name} has invited you to join Accruto"
    )
  end
end
