class ApplicationMailer < ActionMailer::Base
  Rails.application.routes.default_url_options[:host] = ENV['HOST']
  prepend_view_path 'app/views/mailers'

  default from: 'no-reply@horario'

  layout 'mailer'
end
