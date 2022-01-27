# frozen_string_literal: true

module Api
  class MessagesController < ::Api::ApplicationController
    before_action :authenticate_user!

    def conversation
      receiver = User.find(params[:person_id])
      messages = Message.where(sender: current_user, receiver: receiver).
        or(Message.where(sender: receiver, receiver: current_user)).
        order(created_at: :asc)

      render json: messages
    end

    def create
      message = Message.new(text: params[:message], sender: current_user, receiver: User.find(params[:receiver_id]))
      if message.save!
        head :ok
      else
        render_json_error(ServerError.new(details: 'An error occured. Try again later'))
      end
    end
  end
end
