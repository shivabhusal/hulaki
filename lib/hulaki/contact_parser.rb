class Hulaki::ContactParser

  DefaultFilePath = '~/hulaki/contact.csv'

  def perform
    parse
  end

  private
  def parse
    options = {:strings_as_keys => true, :downcase_header => true}
    data = SmarterCSV.process(contact_file, options)
  end

  def contact_file
    @file_path = File.expand_path(DefaultFilePath)
  end
end
