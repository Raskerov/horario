# frozen_string_literal: true

module Api
  class SchedulesController < ::Api::ApplicationController
    before_action :authenticate_user!
    before_action :get_schedule, only: [:show, :destroy]

    def index
      render json: current_company.schedules
    end

    def show
      render json: @schedule
    end

    def create
      @schedule = current_company.schedules.new(schedule_params)

      if @schedule.save!
        params[:user_ids].each do |user_id|
          UserSchedule.create!(user_id: user_id, schedule: @schedule)
        end
        render json: @schedule
      else
        render_json_error(ServerError.new(details: 'An error occured. Try again later'))
      end
    end

    def destroy
      @schedule.destroy!

      head :ok
    end

    private

    def schedule_params
      params.permit(:name, :start_hour, :end_hour, :weekdays)
    end

    def get_schedule
      @schedule ||= Schedule.where(company: current_company).find(params[:id])
    end
  end
end
