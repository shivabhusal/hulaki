require 'hulaki/version'
require 'twilio-ruby'
require 'pry'
require 'hulaki/option_parser'

require "hulaki/sms_handler/sms_handler"
require "hulaki/sms_handler/sms_validator"
require "hulaki/sms_handler/gateway_adapters/twilio"
require "hulaki/sms_handler/gateway_adapters/sparrow"
require 'hulaki/config/config'
require 'hulaki/exceptions'
require 'hulaki/validator'
require 'hulaki/mailer'

class Hulaki::Core
  def initialize(config)
    @config = config
  end

  def perform
    @config.to.each do |recipient|
      if is_phone?(recipient)
        handle_sms(recipient)
      elsif is_email?(recipient)
        handle_email(recipient)
      end
    end
  end

  private

  def is_phone?(number)
    Hulaki::SmsValidator.is_phone_number?(number)
  end

  def is_email?(email)
    # Hulaki::EmailValidator.is_email?(email)
  end

  def handle_sms(recipient)
    sms_handler = Hulaki::SmsHandler.new(
    {
      to: recipient,
      message: @config.message
      })
      if sms_handler.send
        puts "SMS sent successfully to #{recipient}"
        puts @config.message
      end
    end
