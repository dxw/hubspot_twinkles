require "dotenv"
Dotenv.load

require "hubspot-ruby"
require "google_drive"

Hubspot.configure(hapikey: ENV["HUBSPOT_API_KEY"])

require "hubspot_twinkles/runner"
require "hubspot_twinkles/spreadsheet"

module HubspotTwinkles
end
