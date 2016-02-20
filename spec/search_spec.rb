require 'spec_helper'

describe Hulaki::SearchEngine do
  context "successfully finds the contact" do
    it "returns the details of entered value" do 
      expect(Hulaki::SearchEngine.new(database).search('ram')).to match(/ram/)
    end
  end

  context " cannot find the contact" do
    it "should return an error" do
    end
  end
end

def database
  [{"name"=>"ram", "phone"=>"984111111", "email"=>"abc@example.com", "address"=>"balagu kathmandu"}]  
end