# frozen_string_literal: true

module Api
  module Auth
    class SessionsController < ::Devise::SessionsController

      private

      def respond_with(resource, *_args, &_block)
        render json: resource
      end
    end
  end
end
