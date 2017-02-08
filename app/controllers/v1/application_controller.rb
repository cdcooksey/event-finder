module V1
  class ApplicationController < ActionController::API

    def bad_request(message)
      @error = { error: 'bad request', message: message }
      render 'v1/events/error', format: :json, status: :bad_request
    end

  end
end