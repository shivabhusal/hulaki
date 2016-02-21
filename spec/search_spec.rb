require 'spec_helper'

describe Hulaki::SearchEngine do
  context "successfully finds the contact" do
    it "returns the details of entered value" do
      search_engine = Hulaki::SearchEngine.new
      response = search_engine.perform_action("anu didi")
      binding.pry
      expect(response).to eq([[{"Name"=>"ram", "Phone"=>"984111111", "Email"=>"abc@example.com", "Address"=>"balaju kathmandu"}, 1.0]])
    end
  end

  context " cannot find the contact" do
    it "should return an error" do
    end
  end
end

def database
  [{"Name"=>"ram", "Phone"=>"984111111", "Email"=>"abc@example.com", "Address"=>"balaju kathmandu"}, {"Name"=>"shiva", "Phone"=>"984111112", "Email"=>"shiva@example.com", "Address"=>"kalanki kathmandu"}, {"Name"=>"shyam", "Phone"=>"984111113", "Email"=>"shyam@example.com", "Address"=>"gongabu kathmandu"}]  
end