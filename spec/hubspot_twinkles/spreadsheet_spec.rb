require "spec_helper"

RSpec.describe HubspotTwinkles::Spreadsheet do
  subject { described_class.new }

  let(:deal) do
    Hubspot::Deal.new(
      "properties" => {
        "deal_company" => {"value" => "foo inc"},
        "dealname" => {"value" => "bar"},
        "amount_in_home_currency" => {"value" => 120},
        "expected_start_date" => {"value" => DateTime.parse("2020-01-01").to_i * 1000} # The Hubspot API returns the timestamp in milliseconds since 01-01-1970
      },
      "associations" => {}
    )
  end
  let(:session) { double(:session) }
  let(:worksheet) { double(num_rows: 0, save: nil) }
  let(:spreadsheet) { double(worksheets: [worksheet]) }

  before do
    allow(GoogleDrive::Session).to receive(:from_service_account_key) { session }
    allow(session).to receive(:spreadsheet_by_key) { spreadsheet }
  end

  it "adds a deal to the spreadsheet" do
    expect(worksheet).to receive(:[]=).with(1, 1, "foo inc")
    expect(worksheet).to receive(:[]=).with(1, 2, "bar")
    expect(worksheet).to receive(:[]=).with(1, 3, "120")
    expect(worksheet).to receive(:[]=).with(1, 4, "2020-01-01")

    expect(worksheet).to receive(:save).once

    subject.add_deal(deal)
  end

  context "if there are already rows in the worksheet" do
    let(:worksheet) { double(num_rows: 4, save: nil) }

    it "adds the deal to the correct row number" do
      expect(worksheet).to receive(:[]=).with(5, 1, "foo inc")
      expect(worksheet).to receive(:[]=).with(5, 2, "bar")
      expect(worksheet).to receive(:[]=).with(5, 3, "120")
      expect(worksheet).to receive(:[]=).with(5, 4, "2020-01-01")

      expect(worksheet).to receive(:save).once

      subject.add_deal(deal)
    end
  end
end
