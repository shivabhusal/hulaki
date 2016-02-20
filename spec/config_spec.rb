require 'spec_helper'

describe Hulaki::Config, type: :policy do
  describe 'The Config file' do
    let(:loaded_config_file) { File.open(Hulaki::Config::ConfigFilePath) }
    it 'should be present' do
      expect(loaded_config_file).to be_truthy
    end
  end


end