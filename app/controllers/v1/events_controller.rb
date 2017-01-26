module V1
  class EventsController < ApplicationController
    def index

      @events = case search_type
                  when :retailer
                    Event.find_by_retailer_id(search_params[:retailer_id])
                  when :retailer_and_date
                    Event.find_by_retailer_id_and_date(search_params[:retailer_id], search_params[:date])
                end

      render :index, status: :ok
    end

    private

    def search_params
      params.permit(:retailer_id, :date)
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
      false
    end

  end
end