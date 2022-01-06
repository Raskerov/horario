# frozen_string_literal: true

module Api
  class MessagesController < ::Api::ApplicationController
    before_action :authenticate_user!

    def index
      sent_sql = Message.select('distinct on (receiver_id) *').from(Message.where(sender: current_user).order(created_at: :desc)).to_sql
      received_sql = Message.select('distinct on (sender_id) *').from(Message.where(receiver: current_user).order(created_at: :desc)).to_sql
      render json: Message.find_by_sql("#{sent_sql} UNION ALL #{received_sql}")
    end

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
