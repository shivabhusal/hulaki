require 'clipboard'

class Hulaki::Core
  def initialize(config)
    @config = config
  end

  def perform
    if @config.search_keyword
      handle_search_and_clipboard
    else
      handle_messaging
    end
  rescue CSV::MalformedCSVError
    puts 'Your contact.csv file is invalid or has invalid/malformed UTF characters.'.red
    puts 'Please use a valid CSV file.'.red
  end

  private
  def handle_messaging
    puts '~' * 100
    puts 'Welcome to Hulaki : Your best companion! to make your day great.'
    puts '~' * 100

    # It supports multiple recipients like two phonenumbers separated by commas `,`
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
            :to      => recipient,
            :message => @config.message,
            :subject => @config.subject,
            :from    => @config.from
        }).deliver
    puts "Email sent to `#{recipient}`. from `#{get_sender}`"
  end

  def handle_sms(recipient)
    puts "Sending SMS to #{recipient}"
    sms_handler = Hulaki::SmsHandler.new(
        {
            :to      => recipient,
            :message => @config.message,
            :gateway => @config.gateway,
            :from    => @config.from
        })
    if sms_handler.send
      puts "SMS sent successfully to #{recipient} using `#{sms_handler.gateway.class}` gateway"
    end
  end

  def get_sender
    @config[:from] || Hulaki::Config['email']['from']
  end

  def handle_search_and_clipboard
    puts
    response = Hulaki::SearchEngine.new.perform(@config.search_keyword)
    Hulaki::Presenter.new(response).display if response

    if @config.copy_phone_number
      number = response[0][0]['phone_1___value'].gsub(' ', '')
      Clipboard.copy number
      puts "Number '#{number.underline}' is copied to your clipboard"
      puts
    end
  end

end
