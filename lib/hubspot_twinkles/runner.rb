module HubspotTwinkles
  class Runner
    HUBSPOT_PIPELINE_ID = 1831978

    def initialize(deal_id)
      @deal_id = deal_id
    end

    def run!
      spreadsheet.add_deal(deal) if deal_is_new?
    end

    def spreadsheet
      @spreadsheet ||= HubspotTwinkles::Spreadsheet.new
    end

    def deal
      @deal ||= Hubspot::Deal.find(@deal_id)
    end

    def pipeline
      @pipeline ||= Hubspot::DealPipeline.find(HUBSPOT_PIPELINE_ID)
    end

    def new_stage_ids
      pipeline.stages.select { |s| ["Potential", "Radar"].include?(s["label"]) }.map { |s| s["stageId"] }
    end

    def deal_is_new?
      new_stage_ids.include?(deal.properties["dealstage"])
    end
  end
end
