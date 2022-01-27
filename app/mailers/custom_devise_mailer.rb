# frozen_string_literal: true

class CustomDeviseMailer < Devise::Mailer
  Rails.application.routes.default_url_options[:host] = ENV['EMAIL_HOST']

  include Devise::Controllers::UrlHelpers

  def confirmation_instructions(record, token, opts = {})
    @url = Rails.application.routes.url_helpers.confirmation_url({ confirmation_token: token })

    opts[:subject] = if record.confirmed?
                       # user email change confirmation
                       I18n.t('devise_mailer.email_change_confirmation.subject')
                     else
                       # user email confirmation after registration
                       I18n.t('devise_mailer.confirmation.subject')
                     end

    super
  end

  def reset_password_instructions(record, token, opts = {})
    @url = auth_app_url("reset_password/#{token}")
    opts[:subject] = I18n.t('devise_mailer.password_reset.subject')

    super
  end

  def email_changed(record, opts = {})
    opts[:subject] = I18n.t('devise_mailer.email_changed.subject')

    super
  end

  private

  def auth_app_url(path)
    Rails.application.routes.url_helpers.vue_auth_url(vue: path)
  end
end
