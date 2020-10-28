require "spec_helper"

RSpec.describe HubspotTwinkles::Runner do
  describe "#run!" do
    before do
      stub_request(:get, /https:\/\/api\.hubapi\.com\/deals\/v1\/pipelines\/1831978\?hapikey=.+/)
        .to_return(status: 200, body: File.read(File.join("spec", "fixtures", "pipeline.json")), headers: {"Content-Type" => "application/json"})
    end

    subject { described_class.new(json) }
    let(:json) { {objectId: 3244}.to_json }

    context "if the deal is new" do
      before do
        stub_request(:get, /https:\/\/api\.hubapi\.com\/deals\/v1\/deal\/3244\?hapikey=.+/)
          .to_return(status: 200, body: File.read(File.join("spec", "fixtures", "new_deal.json")), headers: {"Content-Type" => "application/json"})
      end

      it "returns true" do
        expect(subject.run!).to be_truthy
      end
    end

    context "if the deal is not new" do
      before do
        stub_request(:get, /https:\/\/api\.hubapi\.com\/deals\/v1\/deal\/3244\?hapikey=.+/)
          .to_return(status: 200, body: File.read(File.join("spec", "fixtures", "old_deal.json")), headers: {"Content-Type" => "application/json"})
      end

      it "returns false" do
        expect(subject.run!).to be_falsey
      end
    end
  end
end
