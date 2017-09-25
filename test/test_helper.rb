$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'tableau_rest_api'

require 'minitest/autorun'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.filter_sensitive_data("<TABLEAU_PASSWORD>") { ENV['TABLEAU_PASSWORD'] }
  config.filter_sensitive_data("<TABLEAU_USERNAME>") { ENV['TABLEAU_USERNAME'] }
end
