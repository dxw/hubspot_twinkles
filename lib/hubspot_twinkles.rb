require "dotenv"
Dotenv.load

require "hubspot-ruby"

Hubspot.configure(hapikey: ENV["HUBSPOT_API_KEY"])

require "hubspot_twinkles/runner"

module HubspotTwinkles
end
