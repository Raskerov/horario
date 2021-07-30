# frozen_string_literal: true

module App
  class ApplicationController < ActionController::Base

    layout 'layouts/application'

    def index
      redirect_to action: :auth, redirect: "app/#{params[:vue]}" unless current_user
    end

    def auth
      redirect_to action: :index if current_user
    end
  end
end
