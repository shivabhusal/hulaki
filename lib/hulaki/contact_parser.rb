class Hulaki::ContactParser
  DEFAULT =  File.expand_path('~/hulaki/contact.csv')
  @@default_file_path = DEFAULT

  def perform
    options = {:strings_as_keys => true, :downcase_header => true}
    SmarterCSV.process(@@default_file_path, options)
  rescue Errno::ENOENT
    raise Hulaki::InvalidFilePath
  end

  private
  class << self
    def default_file_path=(path)
      @@default_file_path = File.expand_path(path)
    end
  end
end
