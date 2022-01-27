# frozen_string_literal: true

module Api
  class SchedulesController < ::Api::ApplicationController
    before_action :authenticate_user!
    before_action :get_schedule, only: [:freedays, :update, :destroy]

    def index
      render json: current_company.schedules
    end

    def freedays
      render json: Freeday.where(user_id: @schedule.user_ids).where("end_date > ?", Date.current.beginning_of_month)
    end

    def create
      @schedule = current_company.schedules.new(schedule_params)
      @schedule.weekdays = allowed_params[:weekdays].split(',')

      if @schedule.save!
        allowed_params[:user_ids].split(',').each do |user_id|
          @schedule.user_schedules.create!(user_id: user_id.to_i)
        end
        render json: @schedule
      else
        render_json_error(ServerError.new(details: 'An error occured. Try again later'))
      end
    end

    def update
      schedule_params.each do |name, value|
        @schedule[name] = value
      end
      @schedule.weekdays = allowed_params[:weekdays].split(',')

      user_ids = allowed_params[:user_ids].split(',').map(&:to_i)
      @schedule.user_schedules.where.not(user_id: user_ids).destroy_all # Remove old ones

      if @schedule.save!
        user_ids.each do |user_id|
          @schedule.user_schedules.find_or_create_by!(user_id: user_id)
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
      params.permit(:name, :start_hour, :end_hour)
    end

    def allowed_params
      params.permit(:user_ids, :weekdays)
    end

    def get_schedule
      @schedule ||= Schedule.where(company: current_company).find(params[:id])
    end
  end
end
