# frozen_string_literal: true

module Api
  class ApplicationController < ActionController::Base
    include ApiErrorHandling

    respond_to :json

    private

    def password_confirmation!
      return if current_user.valid_password?(params[:password])

      render_json_error(RecordInvalidError.new(details: { password: [I18n.t('confirm_with_password.incorrect_password')] }))
    end

    # Redirect to auth part
    alias new_session_path vue_auth_path
  end
end
