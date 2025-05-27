class MemberInvitationMailer < ApplicationMailer
  include Rails.application.routes.url_helpers
  default from: 'from@example.com'  # Change this to your actual default from address

  def new_invitation_email(member, inviter)
    @member = member
    @inviter = inviter
    @tenant = member.tenant
    @user = @member.user

    if @user.invitation_token.present?
      @invitation_url = accept_user_invitation_url(
        invitation_token: @user.raw_invitation_token,
        host: 'localhost:3000'
      )
    end

    mail(
      to: @member.user.email,
      subject: "You've been invited to join #{@tenant.name}"
    )
  end

  def resend_invitation_email(user, inviter)
    @user = user
    @inviter = inviter
    @tenant = user.tenant

    @invitation_url = accept_user_invitation_url(
      invitation_token: @user.raw_invitation_token,
      host: 'localhost:3000'
    ) if @user.invitation_token.present?

    mail(
      to: @user.email,
      subject: "Invitation to join Tenant"
    )
  end
end