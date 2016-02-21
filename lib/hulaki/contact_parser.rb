class Hulaki::ContactParser

  DefaultFilePath = Dir.home + '/hulaki/contact.csv' 
  # For example:
  #   Dir.home => "/home/neha"

  def process
    parser
  end

  private

  def parser
    options = {:strings_as_keys => true, :downcase_header => true}
    data = SmarterCSV.process(DefaultFilePath, options)
  end
end