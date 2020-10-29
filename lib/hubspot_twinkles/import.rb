module HubspotTwinkles
  class Import
    def initialize(json)
      @json = JSON.parse(json)
    end

    def run!
      @json["event"].each do |event|
        HubspotTwinkles::Runner.new(event["objectId"]).run!
      end
    end
  end
end
