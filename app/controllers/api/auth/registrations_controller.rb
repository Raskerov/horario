# frozen_string_literal: true

module Api
  module Auth
    class RegistrationsController < ::Devise::RegistrationsController

      before_action :configure_permitted_parameters

      def create
        company = Company.create!(name: sign_up_params[:company])
        User.create!(
          full_name: sign_up_params[:full_name],
          email: sign_up_params[:email],
          role: 'owner',
          password: sign_up_params[:password],
          password_confirmation: sign_up_params[:password_confirmation],
          company: company
        )

        head :ok
      rescue ActiveRecord::RecordInvalid => e
        render_json_error(RecordInvalidError.new(details: e))
      end

      private

      def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: %i[full_name company email password password_confirmation])
      end
    end
  end
end
