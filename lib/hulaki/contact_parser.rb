class Hulaki::ContactParser

  DefaultFilePath = '~/hulaki/contact.csv'

  def perform
    parse
  end

  private
  def parse
    options = {:strings_as_keys => true, :downcase_header => true}
    SmarterCSV.process(contact_file, options)
  rescue Errno::ENOENT
    puts 'Contact file not found. Make sure there is file'
    puts @file_path
    nil
  end

  def contact_file
    @file_path = File.expand_path(DefaultFilePath)
  end
end
