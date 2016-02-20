require 'spec_helper'
describe Hulaki::EmailValidator do
  let(:validator) { Hulaki::EmailValidator.new(:from=> "shishir@gmail.com", :to=> "ccr@gmail.com", :message=> "hello") }
  context "Validates format of email" do
    it "should validate format of sender's email" do
      expect(validator.validates_format).not_to include("sender_email_format")
    end

    it "should validate format of reciepient's email" do
      expect(validator.validates_format).not_to include("recipient_email_format")
    end

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
