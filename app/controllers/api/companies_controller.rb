# frozen_string_literal: true

module Api
  class CompaniesController < ::Api::ApplicationController
    before_action :authenticate_user!
    before_action :password_confirmation!, only: :destroy

    def show
      render json: current_user.company
    end

    def update
      company = current_user.company
      if company.update!(company_params)
        render json: company
      else
        render_json_error({ name: 'Update not available', details: '', status: 500 })
      end
    end

    def destroy
      company = current_user.company
      company.destroy!

      head :ok
    end

    private

    def company_params
      params.permit(:name)
    end
  end
end
