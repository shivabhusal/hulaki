require 'spec_helper'

describe Hulaki::EmailValidator do
  let(:validator) { Hulaki::EmailValidator.new }
  context "Validates format of email" do
    it "should validate format of sender's email"
    it "should validate format of reciepient's email"
  end
  context "Validates presence of email" do
    it "should validate presence of sender's email" do
      expect(validator.valid_email?).to eq(true)
    end
    it "should validate presence of reciepient's email" do
      expect(validator.valid_email?).to eq(true)
    end
    it "should validate presence of message body" do
      expect(validator.valid_message?).to eq(true)
    end
  end
end
