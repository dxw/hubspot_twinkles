require "sinatra"
require "octokit"
require "dotenv"

Dotenv.load

post "/" do
  # Receive webhook from Hubspot
  webhook_payload = JSON.parse(request.body.read)
  # Send payload to Github as a Repository dispatch event
  client = Octokit::Client.new(access_token: ENV["GITHUB_ACCESS_TOKEN"])
  client.dispatch_event("dxw/hubspot_twinkles", "deal-stage-changed", client_payload: {event: webhook_payload})
end
