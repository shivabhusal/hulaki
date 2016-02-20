require 'yaml'
class Hulaki::Config
  ConfigFilePath = '~/hulaki/config.yml'
  attr_accessor :file_path

  def initialize(params = {})
    @file_path = File.expand_path(params.fetch(:path, ConfigFilePath))
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
end
