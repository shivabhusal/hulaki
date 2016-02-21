require 'spec_helper'

describe Hulaki::Config, type: :policy do
  before(:all) { Hulaki::Twilio.mode = 'test' }

  describe '#file_path' do
    let(:file_path) { File.expand_path Hulaki::Config::ConfigPath }
    let(:invalid_file_path) { File.expand_path '~/hulaki/invalid_config.yml' }

    it 'should able to get valid filepath as param' do
      expect(Hulaki::Config.new(path: file_path).file_path).to eq(file_path)
    end

    it 'should throw an expection if file path is invalid' do
      expect { Hulaki::Config.new(path: invalid_file_path).parse }.to \
      raise_error(Hulaki::InvalidFilePath)
    end
  end

  describe '#parse' do
    it 'should return a hash containg twilio config' do
      config_path = File.expand_path(Hulaki::Config::SampleConfigPath)
      response = Hulaki::Config.new(path: config_path).parse
      expect(response).to include('sms')
      expect(response['sms']).to include('gateway')
    end
  end
end
