require 'ostruct'
# = RecursiveOstruct, a tool to convert every hash inside a Hash/Array to OpenStruct object
#   One of the benifit is, it will respond to very sort of messages like
#   Example:
# 
#       newHash = {'a' => 12}
#       wrappedHash = RecursiveOstruct.new(newHash)
#       wrappedHash.a     # => 12 : a valid call
#       wrappedHash['a']  # => 12 : a valid call
#       wrappedHash[:a]   # => 12 : a valid call
#
#   It is a option for those who do not want to use Rails::ActiveSupport's `HashWithIndifferentAccess`
#
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
