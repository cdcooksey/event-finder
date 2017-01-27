class Event < ActiveRecord::Base
  belongs_to :store
  belongs_to :customer, foreign_key: :customer_id, primary_key: :customer_id

  scope :store_and_retailer, -> { joins(store: :retailer) }

  # https://github.com/geokit/geokit-rails
  acts_as_mappable :default_units   => :miles,
                   :default_formula => :sphere,
                   :lat_column_name => :lat,
                   :lng_column_name => :long

  class << self
    # @Params Integer|String retailer_id
    def find_by_retailer_id(retailer_id)
      store_and_retailer.where('stores.retailer_id = ?', retailer_id)
    end

    # @Params Integer|String retailer_id
    # @Params String date : Eq: "2015-01-20"
    def find_by_retailer_id_and_date(retailer_id, date)
      store_and_retailer.where('stores.retailer_id = ? AND DATE(events.event_at) = ?', retailer_id, date)
    end

    # @Params Float|String lat
    # @Params Float|String long
    # @Params Integer|String radius
    def find_by_location(lat, long, radius)
      within(radius, origin: [lat, long]).store_and_retailer
    end
  end
end
