Devise.setup do |config|
  require 'devise/orm/active_record'

  config.parent_controller = 'Api::ApplicationController'
  config.mailer_sender = 'no-reply@horario'
  config.reconfirmable = true
  config.send_email_changed_notification = true
  config.parent_mailer = 'ApplicationMailer'
  config.mailer = 'CustomDeviseMailer'
  config.password_length = 8..128
  config.navigational_formats = []
  config.paranoid = true
  config.sign_in_after_reset_password = false
  config.extend_remember_period = true
  config.rememberable_options = { same_site: :lax }
end
