class Hulaki::ContactParser

  def initialize(file_name)
    @file = file_name
  end 

  def process
    parser
  end

  private

  def remove_empty
    
  end

  def parser
    file = CSV.read(@file, :headers => true).map(&:to_hash)
  end
end