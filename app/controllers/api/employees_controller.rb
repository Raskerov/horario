# frozen_string_literal: true

module Api
  class EmployeesController < ::Api::ApplicationController
    before_action :authenticate_user!
    before_action :set_employee, only: %i[destroy change_role]

    def index
      render json: current_company.users
    end

    def destroy
      if current_user != @employee
        @employee.destroy!
      else
        return render_json_error(ForbiddenError.new(details: 'You cannot remove yourself'))
      end

      head :ok
    end

    def change_role
      if @employee.update!(role: params[:role])
        head :ok
      else
        render_json_error(ServerError.new(details: 'An error occured. Try again later'))
      end
    end

    private

    def set_employee
      @employee = current_company.users.find(params[:id])
    end
  end
end
