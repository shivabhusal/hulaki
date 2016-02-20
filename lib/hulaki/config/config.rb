require 'yaml'
require 'erb'
class Hulaki::Config
  ConfigPath = '~/hulaki/config.yml'
  SampleConfigPath = 'lib/hulaki/config/config_sample.yml'
  @@config_file_path = ConfigPath
  attr_accessor :file_path

  def initialize(params = {})
    @file_path = File.expand_path(params.fetch(:path, @@config_file_path))
  end

  def parse
    read_file
  end

  private

  def read_file
    read_file = File.open(@file_path).read
    YAML.load(ERB.new(read_file).result)
  rescue Errno::ENOENT => e
    raise Hulaki::InvalidFilePath, 'Invalid file.'
  end

  class << self
    def config_file_path=(config_file_path)
      @@config_file_path = config_file_path
    end

    def config_file_path
      @@config_file_path
    end
  end
end
