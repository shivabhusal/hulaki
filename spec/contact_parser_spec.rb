require 'spec_helper'

describe Hulaki::ContactParser do
  # need to set it to test-default
  after(:each){Hulaki::ContactParser.default_file_path = File.expand_path('../fixtures/contact1.csv',__FILE__)}

  context "If valid csv format is imported" do
    it "should successfully parse the file `contact1`" do
      Hulaki::ContactParser.default_file_path = File.expand_path('../fixtures/contact1.csv',__FILE__)
      contact_parser = Hulaki::ContactParser.new
      response = contact_parser.perform
      expect(response).to be_a_kind_of(Array)
      expect(response[1].keys).to match_array(["name", "first_name", "last_name", "phone_1___type", "phone_1___value", "phone_2___type", "phone_2___value", "address_1___type", "address_1___formatted"])
    end

    it "should successfully parse the file `contact2`" do
      Hulaki::ContactParser.default_file_path = File.expand_path('../fixtures/contact2.csv',__FILE__)
      contact_parser = Hulaki::ContactParser.new
      response = contact_parser.perform
      expect(response).to be_a_kind_of(Array)
      expect(response[1].keys).to match_array(["name", "given_name", "family_name", "phone_1___type", "phone_1___value", "phone_2___type", "phone_2___value", "address_1___type", "address_1___formatted"])
    end
  end

  context "If valid csv format is not present" do
    it "should raise exception" do
      Hulaki::ContactParser.default_file_path = File.expand_path('../fixtures/random.csv',__FILE__)
      contact_parser = Hulaki::ContactParser.new

      expect {contact_parser.perform}.to raise_error Hulaki::InvalidFilePath
    end
  end
end
