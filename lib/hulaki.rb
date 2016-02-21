require "hulaki/version"
require "amatch"
require "hulaki/search_engine"
require 'hulaki/version'
require "hulaki/contact_parser"
require 'smarter_csv'
require 'twilio-ruby'
require 'pry'
require 'hulaki/option_parser'
require "hulaki/sms_handler/sms_handler"
require "hulaki/sms_handler/sms_validator"
require "hulaki/sms_handler/gateway_adapters/twilio"
require "hulaki/sms_handler/gateway_adapters/sparrow"
require 'hulaki/config/config'
require 'hulaki/exceptions'
require 'hulaki/email_validator'
require 'hulaki/mailer'
require 'mail'

class Hulaki::Core
  def initialize(config)
    @config = config
  end

  def perform
    puts '~' * 100
puts 'Welcome to Hulaki : Your best companion! to make your day great.'
    puts '~' * 100

    @config.to.each do |recipient|
      if is_phone?(recipient)
        handle_sms(recipient)
      elsif is_email?(recipient)
        handle_email(recipient)
      end
    end

    puts '~' * 100
    puts @config.message
    puts '~' * 100

  end

  private

  def is_phone?(number)
    Hulaki::SmsValidator.is_phone_number?(number)
  end

  def is_email?(email)
    Hulaki::EmailValidator.is_email?(email)
  end

  def handle_email(recipient)
    puts "Sending email to #{recipient}"
    email_handler = Hulaki::Mailer.new(
        {
            to: recipient,
            body: @config.message,
            sub: @config.subject,
        })
    puts "Email sent to #{recipient}."
  end

  def handle_sms(recipient)
    puts "Sending SMS to #{recipient}"
    sms_handler = Hulaki::SmsHandler.new(
        {
            to: recipient,
            message: @config.message
        })
    if sms_handler.send
      puts "SMS sent successfully to #{recipient}"
    end
  end
end
