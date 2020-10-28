require "spec_helper"

require "rack/test"

ENV["RACK_ENV"] = "test"

require File.expand_path "../lib/webhook_receiver.rb", __dir__

module RSpecMixin
  include Rack::Test::Methods
  def app
    Sinatra::Application
  end
end

# For RSpec 2.x and 3.x
RSpec.configure { |c| c.include RSpecMixin }
