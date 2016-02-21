class Hulaki::EmailValidator
  EmailRegex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  def initialize(options = {})
    @sender_email = options[:from]
    @reciepient_email = options[:to]
    @message = options[:message]
    @errors = {}
  end

  def validates_presence
    validate_sender_email
    validate_recipient_email
    validate_message
    @errors
  end

  def validates_format
    @errors.store("check_sender_email_format", "email format not valid") if EmailRegex.match(@sender_email).nil?
    @errors.store("check_recipient_email_format", "email format not valid") if EmailRegex.match(@reciepient_email).nil?
    @errors
  end

  class << self
    def is_email?(email)
      !is_not_email?(email)
    end

    def is_not_email?(email)
      EmailRegex.match(email).nil?
    end
  end

  private
  def validate_sender_email
    @errors.store("need_sender_email", "sender_email must be present") if @sender_email.nil? || @sender_email.empty?
  end

  def validate_recipient_email
    @errors.store("need_reciepient_email", "reciepient_email must be present") if @reciepient_email.nil? || @reciepient_email.empty?
  end

  def validate_message
    @errors.store("need_message", "Message cannot be blank") if @message.nil? || @message.empty?
  end
end
