module V1
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    def bad_request(message)
      @error = { error: 'bad request', message: message }
      render 'v1/events/error', format: :json, status: :bad_request
    end

  end
end