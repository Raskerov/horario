# frozen_string_literal: true

module Api
  class CompaniesController < ::Api::ApplicationController
    before_action :authenticate_user!
    before_action :password_confirmation!, only: :destroy

    def show
      render json: current_company
    end

    def update
      if current_company.update!(company_params)
        current_company.reload
        render json: current_company
      end
    rescue ActiveRecord::RecordInvalid => e
      render_json_error(RecordInvalidError.new(details: e))
    end

    def destroy
      current_company.destroy!

      head :ok
    end

    private

    def company_params
      params.permit(:name)
    end
  end
end
