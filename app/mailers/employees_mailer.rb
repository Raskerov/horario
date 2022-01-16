class EmployeesMailer < ApplicationMailer
  def invite(user_id)
    I18n.with_locale('pl') do
      invitation_email(user_id, I18n.t('invitation_mailer.subject'))
    end
  end

  private

  def invitation_email(user_id, subject)
    @user = User.find(user_id)
    @company = @user.company
    @url = activation_url

    mail(to: @user.email, subject: subject, template_name: 'invite')
  end

  def activation_url
    Rails.application.routes.url_helpers.vue_auth_url(vue: "accept_invitations/#{@user.confirmation_token}")
  end
end
