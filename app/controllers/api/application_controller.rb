# frozen_string_literal: true

module Api
  class ApplicationController < ActionController::Base
    include ApiErrorHandling

    respond_to :json

    private

    def current_company
      current_user.company
    end

    def password_confirmation!
      return if current_user.valid_password?(params[:password])

      render_json_error(RecordInvalidError.new(details: { password: [I18n.t('confirm_with_password.incorrect_password')] }))
    end

    # overwrite default method to avoid exposing model attributes on success
    def respond_with(resource, *_args, &_block)
      return render_json_error(RecordInvalidError.new(details: resource.errors)) if resource.try(:errors).present?

      render json: {}
    end

    alias new_session_path vue_auth_path
  end
end
