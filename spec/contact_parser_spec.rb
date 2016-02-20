require 'spec_helper'

describe ContactParser do 

  context "If valid csv format is imported" do
    let(:file_name) { File.open('/home/neha/contact.csv') }

    it "should successfully import the file" do
      expect{ContactParser.new(file_name)}
    end
    it "should eradicate empty rows"
    it "should store the imported file in hash"
  end

  context "If valid csv format is not improted" do
    it "should raise exception"
  end
  
end