module Staccato::V4
  # The `Tracker` class has methods to create all `Hit` types
  #   using the tracker and client id
  # 
  # @author Tony Pitale
  class Tracker
    attr_accessor :events

    # sets up a new tracker
    # @param measurement_id [String] the measurement id from GA
    # @param api_secret [String] the required api secret key
    # @param client_id [String, nil] unique value to track user sessions
    # @param options [Hash]
    def initialize(measurement_id, api_secret, client_id = nil, options = {})
      @measurement_id = measurement_id
      @api_secret = api_secret
      @client_id = client_id
      @adapters = []

      self.events = []
    end

    def adapter=(adapter)
      @adapters = [adapter.new(default_uri)]
    end

    def add_adapter(adapter)
      @adapters << adapter.new(default_uri)
    end

    # The measurement id for GA
    # @return [String]
    def measurement_id
      @measurement_id
    end

    # The required api secret for GA
    # @return [String]
    def api_secret
      @api_secret
    end

    # The unique client id
    # @return [String]
    def client_id
      @client_id ||= Staccato.build_client_id
    end

    # Add an Event instance to the events to be sent
    def add(event)
      self.events << event
    end

    # post the hit to GA collection endpoint
    # @return [Net::HTTPOK] the GA api always returns 200 OK
    def track
      post
    end

    # clear events array
    def clear
      self.events = []
    end

    def default_uri
      Staccato::V4.ga_collection_uri.tap do |uri|
        uri.query = URI.encode_www_form(params)
      end
    end

    private

    # @private
    def params
      {
        measurement_id: @measurement_id,
        api_secret: @api_secret
      }
    end

    # @private
    def body
      Staccato::V4.encode_body(client_id, events)
    end

    # @private
    def single_adapter?
      adapters.length == 1
    end

    # @private
    def post
      single_adapter? ? post_first : post_all
    end

    # @private
    def post_first
      adapters.first.post(body)
    end

    # @private
    def post_all
      adapters.map { |adapter| adapter.post(body) }
    end

    # @private
    def adapters
      @adapters.empty? ? [default_adapter] : @adapters
    end

    # @private
    def default_adapter
      @default_adapter ||= Staccato.default_adapter.new(default_uri)
    end
  end

  # A tracker which does no tracking
  #   Useful in testing
  class NoopTracker
    attr_accessor :hit_defaults

    # (see Tracker#initialize)
    def initialize(measurement_id = nil, client_id = nil, options = {})
      self.events = []
    end

    def adapter=(*)
      []
    end

    def add_adapter(*)
      []
    end

    # (see Tracker#id)
    def measurement_id
      nil
    end

    # (see Tracker#client_id)
    def client_id
      nil
    end

    # (see Tracker#track)
    def track(events)
    end

    def default_uri
      Staccato::V4.ga_collection_uri
    end
  end
end
