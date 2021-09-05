# frozen_string_literal: true

module Api
  class UsersController < ::Api::ApplicationController
    before_action :authenticate_user!

    def show
      render json: current_user
    end

    def update
      if current_user.update!(user_params)
        render json: current_user
      else
        render_json_error({ name: 'Update not available', details: '', status: 500 })
      end
    end

    private

    def user_params
      params.permit(:full_name, :email)
    end
  end
end
