require 'spec_helper'
describe Hulaki::Mailer do
  let(:mail) { Hulaki::Mailer.new(:to=> "sis.ccr@gmail.com", sub: "test", :body=> "hello") }

    it "should send email to reciepient email adress" do
      expect(mail.deliver).to eq("sent")
    end
end
