require 'smarter_csv'
require 'yaml'
require 'erb'

class Hulaki::Config
  ConfigPath       = '~/hulaki/config.yml'
  SampleConfigPath = File.expand_path('../sample.config.yml', __FILE__)
  SampleContactPath = File.expand_path('../sample.contact.csv', __FILE__)
  SampleTemplatePath = File.expand_path('../sample.template.html.erb', __FILE__)

  @@config_file_path = File.expand_path(ConfigPath)

  class << self
    def [](key)
      config[key]
    end

    def config_file_path=(config_file_path)
      @@config_file_path = File.expand_path(config_file_path)
    end

    private

    def config
      @@config ||= parse
    end

    def parse
      read_file = File.open(@@config_file_path ).read
      YAML.load(ERB.new(read_file).result)
    rescue Errno::ENOENT => e
      raise Hulaki::InvalidFilePath, 'Invalid file.'
    end
  end
end
