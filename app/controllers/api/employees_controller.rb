# frozen_string_literal: true

module Api
  class EmployeesController < ::Api::ApplicationController
    before_action :authenticate_user!

    def index
      render json: current_company.users
    end

    def destroy
      employee = current_company.users.find(params[:id])

      if current_user != employee
        employee.destroy!
      else
        render_json_error(ForbiddenError.new(details: 'You cannot remove yourself'))
      end
    end
  end
end
