class Event < ActiveRecord::Base
  belongs_to :store
  belongs_to :customer, foreign_key: :customer_id, primary_key: :customer_id

  class << self
    # @Params Integer|String retailer_id
    def find_by_retailer_id(retailer_id)
      joins(store: :retailer).where('stores.retailer_id = ?', retailer_id)
    end

    # @Params Integer|String retailer_id
    # @Params String date : Eq: "2015-01-20"
    def find_by_retailer_id_and_date(retailer_id, date)
      joins(store: :retailer).where('stores.retailer_id = ? AND DATE(events.event_at) = ?', retailer_id, date)
    end

  end
end
