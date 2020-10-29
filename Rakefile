$LOAD_PATH.unshift File.join(File.dirname(__FILE__), "lib")

require "rspec/core/rake_task"
require "standard/rake"
require "json"
require "hubspot_twinkles"

RSpec::Core::RakeTask.new(:spec)

task default: %i[standard spec]

task :import do
  HubspotTwinkles::Import.new($stdin.gets).run!
end
