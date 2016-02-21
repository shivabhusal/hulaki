require 'spec_helper'
describe Hulaki::EmailValidator do
  let(:validator) { Hulaki::EmailValidator.new(:from=> "shishir@gmail.com", :to=> "ccr@gmail.com", :message=> "hello") }
  context "Validates format of email" do
    it "should validate format of sender's email" do
      expect(validator.validates_format).not_to include("check_sender_email_format")
    end

    it "should validate format of reciepient's email" do
      expect(validator.validates_format).not_to include("check_recipient_email_format")
    end

  end

  context "Validates presence of email" do
    it "should validate presence of sender's email" do
      expect(validator.validates_presence).not_to include("need_sender_email")
    end
    it "should validate presence of reciepient's email" do
      expect(validator.validates_presence).not_to include("need_reciepient_email")
    end
    it "should validate presence of message body" do
      expect(validator.validates_presence).not_to include("need_message")
    end
  end
end
