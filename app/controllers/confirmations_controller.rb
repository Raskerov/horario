# frozen_string_literal: true

class ConfirmationsController < ::Devise::ConfirmationsController
  clear_respond_to
  respond_to :html

  def show
    sign_out :user if current_user.present?

    self.resource = resource_class.confirm_by_token(params[:confirmation_token])

    if resource.errors.empty?
      redirect_to vue_auth_url(app_query)
    else
      redirect_to vue_app_path
    end
  end

  private

  def app_query
    { vue: 'login', email_confirmed: true }
  end
end
