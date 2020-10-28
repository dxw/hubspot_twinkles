require "sinatra_helper"

describe "webhook receiver" do
  it "sends the payload on to Github" do
    payload = [
      {
        foo: "bar"
      }
    ]

    stub = stub_request(:post, "https://api.github.com/repos/dxw/hubspot_twinkles/dispatches")
      .with({
        body: {
          client_payload: {
            event: payload
          },
          event_type: "deal-stage-changed"
        }.to_json
      })

    post "/", payload.to_json

    expect(stub).to have_been_requested
  end
end
