require "spec_helper"

RSpec.describe HubspotTwinkles::Runner do
  describe "#run!" do
    before do
      stub_request(:get, /https:\/\/api\.hubapi\.com\/deals\/v1\/pipelines\/1831978\?hapikey=.+/)
        .to_return(status: 200, body: File.read(File.join("spec", "fixtures", "pipeline.json")), headers: {"Content-Type" => "application/json"})
    end

    subject { described_class.new(deal_id) }
    let(:deal_id) { 3244 }

    context "if the deal is new" do
      before do
        stub_request(:get, /https:\/\/api\.hubapi\.com\/deals\/v1\/deal\/3244\?hapikey=.+/)
          .to_return(status: 200, body: File.read(File.join("spec", "fixtures", "new_deal.json")), headers: {"Content-Type" => "application/json"})
      end

      it "adds the deal to the spreadsheet" do
        expect(subject.spreadsheet).to receive(:add_deal).with(subject.deal)

        subject.run!
      end
    end

    context "if the deal is not new" do
      before do
        stub_request(:get, /https:\/\/api\.hubapi\.com\/deals\/v1\/deal\/3244\?hapikey=.+/)
          .to_return(status: 200, body: File.read(File.join("spec", "fixtures", "old_deal.json")), headers: {"Content-Type" => "application/json"})
      end

      it "does not add the deal to the spreadsheet" do
        expect(subject.spreadsheet).to_not receive(:add_deal)

        subject.run!
      end
    end
  end
end
