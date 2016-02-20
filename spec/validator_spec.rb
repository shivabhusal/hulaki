require 'spec_helper'
describe Validator do
  context "Validates format of email"
    it "should validate format of sender's email"
    it "should validate format of reciepient's email"
  end
  context "Validates presence of email" do
    it "should validate presence of sender's email"
    it "should validate presence of reciepient's email"
    it "should validate presence of message body"
  end

end
