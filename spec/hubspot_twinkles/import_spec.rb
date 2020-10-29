require "spec_helper"

RSpec.describe HubspotTwinkles::Import do
  let(:json) do
    {
      "event" => [
        {
          "attemptNumber" => 0,
          "changeSource" => "CRM",
          "eventId" => 100,
          "objectId" => 123,
          "occurredAt" => 1603978690149,
          "portalId" => 5360317,
          "propertyName" => "dealstage",
          "propertyValue" => "sample-value",
          "subscriptionId" => 337554,
          "subscriptionType" => "deal.propertyChange"
        }
      ]
    }.to_json
  end

  subject { described_class.new(json) }

  it "triggers the runner" do
    runner = double(:runner)
    expect(HubspotTwinkles::Runner).to receive(:new).with(123) { runner }
    expect(runner).to receive(:run!)
    subject.run!
  end
end
