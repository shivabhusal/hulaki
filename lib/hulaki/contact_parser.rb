class Hulaki::ContactParser

  def initialize(file_name)
    @file = file_name
  end 

  def parse_file
    file = CSV.read(@file, :headers => true).map(&:to_hash)
  end

end