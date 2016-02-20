class Hulaki::SmsValidator
  attr_reader :errors, :to, :message

  def initialize(params = {})
    @errors = {}
    @to = params.fetch(:to, params[:recipient])
    @message = params.fetch(:message, params[:msg])
  end

  def validate
    to || (raise Hulaki::InvalidPhoneNumber, 'Phone number should be present.')
    message || (raise Hulaki::InvalidMessageBody, 'Message body should be present.')
  end
end
