$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pry'
require 'hulaki'
RSpec.configure do |config|
  config.before(:all) do |ex|
    Hulaki::Twilio.mode = 'test'
    Hulaki::Config.config_file_path = 'lib/hulaki/config/config_sample.yml'
  end
  config.after(:all) do
    Hulaki::Twilio.mode = 'live'
    Hulaki::Config.config_file_path = Hulaki::Config::ConfigPath
  end
end
