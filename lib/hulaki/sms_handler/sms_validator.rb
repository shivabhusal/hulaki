class Hulaki::SmsValidator
  attr_reader :errors, :to, :from, :message, :gateway
  RegexPhoneNumber = /(?:\+?|\b)[0-9]{10}\b/

  def initialize(params = {})
    @errors = {}
    @to = params.fetch(:to, params[:recipient])
    @from = params.fetch(:from, params[:sender])
    @message = params.fetch(:message, params[:msg])
  end

  def validate
    to || (raise Hulaki::InvalidPhoneNumber, 'Recipient phone number should be present.')
    from || (raise Hulaki::InvalidPhoneNumber, 'Sender phone number should be present.')
    message || (raise Hulaki::InvalidMessageBody, 'Message body should be present.')

    check_if_number_invalid
  end

  private
  def check_if_number_invalid
    RegexPhoneNumber.match(to) || (raise Hulaki::InvalidPhoneNumber,
                                         "Phone number '#{to}' is invalid.")

    RegexPhoneNumber.match(from) || (raise Hulaki::InvalidPhoneNumber,
                                           "Phone number '#{from}' is invalid.")
  end
end
