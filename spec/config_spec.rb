require 'spec_helper'

describe Hulaki::Config, type: :policy do
  # need to set it to test-default
  after(:each){Hulaki::Config.config_file_path = Hulaki::Config::SampleConfigPath}

  describe 'Invalid condition' do
    let(:file_path) { File.expand_path Hulaki::Config::ConfigPath }
    let(:invalid_file_path) { File.expand_path '~/hulaki/invalid_config.yml' }

    it 'should throw an expection if file path is invalid' do
      Hulaki::Config.config_file_path = invalid_file_path
      expect { Hulaki::Config.send(:parse) }.to raise_error(Hulaki::InvalidFilePath)
    end
  end

  describe 'Valid condition' do
    it 'should return a hash containg twilio config' do
      config_path = File.expand_path(Hulaki::Config::SampleConfigPath)
      response = Hulaki::Config.send(:parse)

      keys = response['sms'].keys

      expect(response).to include('sms')
      expect(keys).to match_array(['twilio', 'nexmo', 'sparrow'])
      expect(response['sms'][keys.last].keys).to include('API_KEY')
      expect(response['sms'][keys.last].keys).to include('API_SECRET')
    end
  end
end
