# frozen_string_literal: true

module Api
  class UsersController < ::Api::ApplicationController
    before_action :authenticate_user!

    def show
      render json: current_user
    end
  end
end
