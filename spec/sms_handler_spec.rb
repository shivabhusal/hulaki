require 'spec_helper'

describe Hulaki::SmsHandler, type: :service do
  before(:all) { Hulaki::Twilio.mode = 'test' }
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

      it 'should select Twilio as Default SMS Gateway' do
        expect(Hulaki::SmsHandler.new.gateway).to \
        be_a_kind_of(Hulaki::Twilio)
      end
    end

    context 'Twilio as gateway' do
      it 'should throw exception if no contact number provided' do
        expect { Hulaki::SmsHandler.new.send }.to raise_error(Hulaki::InvalidPhoneNumber)
      end
    end

    context 'Successful SMS delivery' do
      let(:valid_params) do
        {
            to: '9843498764',
            from: '9843498765',
            msg: 'Hello'
        }
      end
      it 'should return truthy value if passed with valid arguments' do
        expect { Hulaki::SmsHandler.new(valid_params).send }.not_to raise_error
      end

      it "should set Twilio's mode to 'test'" do
        Hulaki::SmsHandler.new(valid_params).send
        expect(Hulaki::Twilio.mode).to eq('test')
      end
    end
  end
end















