module V1
  class PurchasesController < ApplicationController

    def create
      begin

        # I'm not sure what 'items' are in the context of this project.

        @receipt = Receipt.create!(customer:      customer,
                                   store:         store,
                                   total_items:   receipt_params[:total_items],
                                   total_amount:  receipt_params[:total_amount])
      rescue ActiveRecord::RecordInvalid => e
        return bad_request(e.message)
      end

      render :show, status: :created
    end

    private

    def receipt_params
      params.permit(:customer_id, :store_id, :total_items, :total_amount)
    end

    def customer
      Customer.where(customer_id: receipt_params[:customer_id]).first
    end

    def store
      Store.where(id: receipt_params[:store_id]).first
    end

  end
end