# frozen_string_literal: true

module Api
  class AcceptInvitationsController < ::Api::ApplicationController
    class EmployeeAlreadyAcceptedError < StandardError; end

    def fetch_confirmation
      raise EmployeeAlreadyAcceptedError if user.confirmed_at

      render json: { email: user.email, company: company.name}
    rescue ActiveRecord::RecordNotFound, EmployeeAlreadyAcceptedError
      render_404_error
    end

    def register
      if user.update!(register_params)
        user.update!(confirmed_at: Time.current)
        head :ok
      end
    rescue ActiveRecord::RecordInvalid => e
      render_json_error(RecordInvalidError.new(details: e))
    end

    private

    def register_params
      params.permit(:full_name, :password, :password_confirmation)
    end

    def company
      @_company ||= user.company
    end

    def user
      @_user = User.find_by!(confirmation_token: params[:token])
    end
  end
end
