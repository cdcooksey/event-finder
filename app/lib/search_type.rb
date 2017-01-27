class SearchType

  # Earlier in the commit history, the controller had logic that did what this class does.
  # It was a little more controller business logic for my tastes, and it didn't cover all
  # test cases.  Abstract out the logic to determine which search query to run, and cover
  # all edge cases.  See spec for more details.

  def initialize(params = {})
    raise StandardError, bad_search_response if params.nil? || params.empty?

    @retailer_id  = params.fetch(:retailer_id, nil)
    @date         = params.fetch(:date, nil)
    @lat          = params.fetch(:lat, nil)
    @long         = params.fetch(:long, nil)
    @radius       = params.fetch(:radius, nil)

    self
  end

  def type
    type = nil
    type = :retailer if has_retailer_without_date?
    type = :retailer_and_date if has_retailer_and_date?
    type = :location if has_coordinates?
    raise StandardError, bad_search_response unless type
    type
  end

  private

  # I could use attr_reader at the top of the class, but I want to expose
  # as little as possible.  We'll use private methods instead.  This will
  # help catch edge cases as well.

  def retailer_id
    return nil if @retailer_id.nil? || @retailer_id.try(:empty?)
    @retailer_id
  end

  def date
    return nil if @date.nil? || @date.try(:empty?)
    @date
  end

  def lat
    return nil if @lat.nil? || @lat.try(:empty?)
    @lat
  end

  def long
    return nil if @long.nil? || @long.try(:empty?)
    @long
  end

  def radius
    return nil if @radius.nil? || @radius.try(:empty?)
    @radius
  end

  # We'll move the business logic of deciding with search query to use in here.

  def has_coordinates?
    return true if lat && long && radius
    false
  end

  def has_retailer_without_date?
    return false unless retailer_id && date.nil?
    true
  end

  def has_retailer_and_date?
    return true if retailer_id && date
    false
  end

  def bad_search_response
    'Request must include retailer_id, retailer_id and date, or lat, long, and radius'
  end

end