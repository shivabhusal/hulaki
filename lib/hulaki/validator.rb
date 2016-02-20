class Hulaki::EmailValidator

  def initialize(options = {} )
    @sender_email = options[:from]
    @reciepient_email = options[:to]
    @message = options[:message]
    @errors = {}
  end

  def validates_presence
    validate_sender_email && validate_recipient_email && validate_message
    @errors
  end
  private
    def validate_sender_email
      @errors.store("sender_email", "sender_email must be present") if  @sender_email.nil?||@sender_email.empty?
    end
    def validate_recipient_email
      @errors.store("reciepient_email", "reciepient_email must be present") if @reciepient_email.nil?||  @reciepient_email.empty?
    end
    def validate_message
      @errors.store("message", "Message cannot be blank") if @message.nil? || @message.empty?
    end

end
