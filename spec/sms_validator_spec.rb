require 'spec_helper'

describe Hulaki::SmsValidator, type: :policy do
  describe '.validate' do
    let(:valid_number) {'9843488767'}
    context 'Presence Validation' do
      it 'should return say that the phone-number is required' do
        expect { Hulaki::SmsValidator.new(msg: 'hello').validate }.to raise_error(Hulaki::InvalidPhoneNumber)
      end

      it 'should return say that the message is required' do
        expect { Hulaki::SmsValidator.new(to: valid_number).validate }.to raise_error(Hulaki::InvalidMessageBody)
      end
    end
  end
end