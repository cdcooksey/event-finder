module V1
  class EventsController < ApplicationController

    # The README.md instructions say to create "endspoints" (plural) for one or more of the search types.
    # All three search types return an Event collection, so I've consolidated it into a single endpoint.
    # Consumers of the API shouldn't need to hit 3 different endpoints to find Events.

    def index
      begin
        @events = events
      rescue StandardError => e
        return bad_request(e.message)
      end

      render :index, status: :ok
    end

    private

    def search_params
      params.permit(:retailer_id, :date, :lat, :long, :radius)
    end

    def events
      case SearchType.new(search_params).type
        when :retailer
          by_retailer
        when :retailer_and_date
          by_retailer_and_date
        when :location
          by_location
        else
          nil
      end
    end

    def by_retailer
      Event.find_by_retailer_id(search_params[:retailer_id])
    end

    def by_retailer_and_date
      Event.find_by_retailer_id_and_date(search_params[:retailer_id], search_params[:date])
    end

    def by_location
      Event.find_by_location(search_params[:lat], search_params[:long], search_params[:radius])
    end
  end
end