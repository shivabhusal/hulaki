require 'spec_helper'

describe Hulaki::SmsValidator, type: :policy do
  describe '.validate' do
    let(:valid_number) { '9843488767' }
    let(:invalid_number) { '1asd1111111' }
    context 'Presence Validation' do
      it 'should return say that the receiver\'s phone-number is required' do
        expect { Hulaki::SmsValidator.new(msg: 'hello').validate }.to \
        raise_error(Hulaki::InvalidPhoneNumber)
      end

      it 'should return say that the message is required' do
        expect { Hulaki::SmsValidator.new(to: valid_number,
                                          from: valid_number).validate }.to \
        raise_error(Hulaki::InvalidMessageBody)
      end
    end

    context 'Validation of Phone Number' do
      it 'should raise exception when number is invalid' do
        expect { Hulaki::SmsValidator.new(msg: 'hello',
                                          to: invalid_number,
                                          from: valid_number).validate }.to \
        raise_error(Hulaki::InvalidPhoneNumber)
      end
    end
  end
end
