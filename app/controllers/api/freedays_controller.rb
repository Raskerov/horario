# frozen_string_literal: true

module Api
  class FreedaysController < ::Api::ApplicationController
    before_action :authenticate_user!

    def index
      freedays = current_user.freedays.where("end_date > ?", Date.now) # Only ongoing or future ones
      if current_user.managing?
        freedays += Freeday.where(user_id: current_company.users.pluck(:id)).requested
      end

      render json: freedays
    end

    def create
      freeday = Freeday.new(create_params)
      if current_user.managing?
        freeday.status = 'accepted'
        freeday.accepted_by = current_user
      end

      if freeday.save!
        render json: freeday
      else
        render_json_error(ServerError.new(details: 'An error occured. Try again later'))
      end
    end

    def update
    end

    private

    def create_params
      params.permit(:user_id, :start_date, :end_date, :reason).merge({ status: 'requested' })
    end

    def update_params
      params.permit(:user_ids, :reason, :status)
    end
  end
end
