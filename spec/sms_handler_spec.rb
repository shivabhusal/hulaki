require 'spec_helper'

describe Hulaki::SmsHandler, type: :service do
  describe '.send' do
    context 'Phone number Validation' do
      it 'should throw exception if phone number is invalid' do

      end
      it 'should respond truthy if valid phone number'
    end
  end

  describe 'Initializer' do
    context 'Selecting Appropriate SMS Gateway' do
      it 'should select Twilio as SMS Gateway' do
        expect(Hulaki::SmsHandler.new(gateway: 'Twilio').gateway).to \
        be_a_kind_of(Hulaki::Twilio)
      end
      it 'should select SparrowSMS as SMS Gateway' do
        expect(Hulaki::SmsHandler.new(gateway: 'Sparrow').gateway).to \
        be_a_kind_of(Hulaki::Sparrow)
      end
    end

    context 'Twilio as gateway' do
      it 'should throw exception if no contact number provided' do
        expect { Hulaki::SmsHandler.new.send }.to raise_error(Hulaki::InvalidPhoneNumber)
      end
    end
  end
end















