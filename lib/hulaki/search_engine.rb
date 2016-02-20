include Amatch
class Hulaki::SearchEngine

  def initialize(data)
    @data = data
  end

  def search(contact)
    @contact = contact
    database = @data.map{|x| pt = PairDistance.new(x["Name"]).match(@contact.to_s); [x, pt]}
    p=database.sort {|x,y| y[1] <=> x[1]}
    p.select{|x| x[1] >= 0.5}

  end
  
end