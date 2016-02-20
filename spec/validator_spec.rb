require 'spec_helper'
describe Hulaki::EmailValidator do
  let(:validator) { Hulaki::EmailValidator.new(:from=> "a", :to=> "b", :message=>"hello")  }
  context "Validates format of email" do
    it "should validate format of sender's email"

    it "should validate format of reciepient's email"
  end

  context "Validates presence of email" do
    it "should validate presence of sender's email" do
      expect(validator.validates_presence).not_to include("sender_email")
    end
    it "should validate presence of reciepient's email" do
      expect(validator.validates_presence).not_to include("reciepient_email")
    end
    it "should validate presence of message body" do
      expect(validator.validates_presence).not_to include("message")
    end
  end
end
