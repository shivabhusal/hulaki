class Hulaki::SmsHandler
  attr_reader :gateway, :to, :from, :message

  def initialize(params = {})
    @gateway = get_gateway(params.fetch(:gateway, 'twilio'))
    @to = params.fetch(:to, params[:recipient])
    @from = params.fetch(:from, params[:sender])
    @message = params.fetch(:message, params[:msg])
  end

  def send
    verify_details
  end

  private
  attr_reader :to, :message

  def get_gateway(gateway_name)
    klass = gateway_name.to_s.capitalize
    eval("Hulaki::#{klass}").new()
    # eval("Hulaki::#{klass}").new(gateway_config(gateway_name))
  rescue SyntaxError => e
    raise Hulaki::InvalidSmsGateway, 'Please choose a valid sms gateway'
  end

  def verify_details
    Hulaki::SmsValidator.new(to: to, from: from, message: message).validate
  end

  def gateway_config(gateway_name)
    Hulaki::Config.parse
  end
end
