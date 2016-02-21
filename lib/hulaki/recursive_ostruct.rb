require 'ostruct'
class RecursiveOstruct
  def self.ostruct(object)
    if object.is_a?(Hash)
      object = object.clone
      object.each do |key, value|
        object[key] = ostruct(value)
      end
      OpenStruct.new(object)
    else
      object
    end
  end
end
