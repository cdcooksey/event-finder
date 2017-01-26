module V1
  class EventsController < ApplicationController
    def index

      begin
        @events = events
      rescue StandardError => e
        return bad_request(e.message)
      end

      render :index, status: :ok
    end

    private

    def events
      case search_type
      when :retailer
        Event.find_by_retailer_id(search_params[:retailer_id])
      when :retailer_and_date
        Event.find_by_retailer_id_and_date(search_params[:retailer_id], search_params[:date])
      when :location
        Event.find_by_location(search_params[:lat], search_params[:long], search_params[:radius])
      else
        raise StandardError, bad_search_response
      end
    end

    def search_params
      params.permit(:retailer_id, :date, :lat, :long, :radius)
    end

    def has_coordinates?
      search_params[:lat] && search_params[:long] && search_params[:radius]
    end

    def has_retailer_without_date?
      search_params[:retailer_id] && search_params[:date].nil?
    end

    def has_retailer_and_date?
      search_params[:retailer_id] && search_params[:date]
    end

    def search_type
      return :retailer if has_retailer_without_date?
      return :retailer_and_date if has_retailer_and_date?
      return :location if has_coordinates?
      false
    end

    def bad_search_response
      'Request must include retailer_id, retailer_id and date, or lat, long, and radius'
    end

  end
end