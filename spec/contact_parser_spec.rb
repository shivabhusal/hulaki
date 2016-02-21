require 'spec_helper'

describe Hulaki::ContactParser do 

  context "If valid csv format is imported" do

    it "should successfully parse the file" do
      contact_parser = Hulaki::ContactParser.new
      response = contact_parser.process
      expect(response).to be_a_kind_of(Array)
    end
    
  end

  context "If valid csv format is not improted" do
    it "should raise exception"
  end
  
end

