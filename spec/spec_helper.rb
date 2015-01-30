require "bundler/setup"
require "codeforces"

require "vcr"
VCR.configure do |conf|
  conf.cassette_library_dir = "spec/api_fixtures"
  conf.hook_into :webmock
  conf.configure_rspec_metadata!
end

if ENV["CODEFORCES_DEBUG"] === "yes"
  require "byebug"
end

