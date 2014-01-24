# encoding: utf-8

require 'coveralls'
Coveralls.wear!

%w{
  bundler/setup
  wit-ai
  webmock/rspec
}.each { |f| require f }

Bundler.require(:default, :test) if defined?(Bundler)

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.mock_framework = :rspec
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
  config.color_enabled = true

  config.before { WebMock.disable_net_connect! }
end
