# frozen_string_literal: true

module ApiErrorHandling
  extend ActiveSupport::Concern

  class ApiError < StandardError
    attr_reader :details

    def initialize(details: {})
      @details = details
    end

    def name
      self.class.name.demodulize
    end
  end

  class NotAuthorizedError < ApiError
    def status
      :unauthorized
    end
  end

  class ForbiddenError < ApiError
    def status
      :forbidden
    end
  end

  class ServerError < ApiError
    def status
      :internal_server_error
    end
  end

  class NotFoundError < ApiError
    def status
      :not_found
    end
  end

  class RecordInvalidError < ApiError
    def status
      :bad_request
    end
  end

  class InvalidAuthError < ApiError
    def status
      :gone
    end
  end

  class UnprocessableError < ApiError
    def status
      :unprocessable_entity
    end
  end

  def render_json_error(error)
    raise ArgumentError unless error.is_a?(ApiError)

    render json: { error: error.name, details: error.details }, status: error.status
  end

  def render_500_error(exception)
    raise(exception) if raise_exceptions?

    render_json_error(ServerError.new)
  end

  def render_404_error
    render_json_error(NotFoundError.new)
  end

  def render_403_error
    render_json_error(ForbiddenError.new)
  end

  def raise_exceptions?
    Rails.env.development? || Rails.env.test?
  end

  included do
    rescue_from ::Exception, with: :render_500_error
    rescue_from ::ActiveRecord::RecordNotFound, with: :render_404_error
  end
end
