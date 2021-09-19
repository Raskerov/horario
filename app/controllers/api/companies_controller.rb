# frozen_string_literal: true

module Api
  class CompaniesController < ::Api::ApplicationController
    before_action :authenticate_user!
    before_action :password_confirmation!, only: :destroy

    def show
      render json: current_company
    end

    def users
      render json: current_company.users
    end

    def update
      if current_company.update!(company_params)
        current_company.reload!
        render json: current_company
      else
        render_json_error({ name: 'Update not available', details: '', status: 500 })
      end
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
