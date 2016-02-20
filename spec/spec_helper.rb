$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pry'
require 'hulaki'
RSpec.configure do |config|
  config.before(:all) do |ex|
    Hulaki::Twilio.mode = 'test'
  end
  config.after(:all) do
    Hulaki::Twilio.mode = 'live'
  end
end
