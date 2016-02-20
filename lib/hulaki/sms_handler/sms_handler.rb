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
    @gateway.send
  end

  private

  def get_gateway(gateway_name = nil)
    config = gateway_config

    gateway_name ||= config['name']

    klass = gateway_name.to_s.capitalize

    eval("Hulaki::#{klass}").new(
        {
            config: config,
            to: to,
            from: from || gateway_config['TWILIO_PHONE_NUMBER'],
            message: message
        })

  rescue SyntaxError => e
    raise Hulaki::InvalidSmsGateway, 'Please choose a valid sms gateway'
  end

  def verify_details
    Hulaki::SmsValidator.new(to: to,
                             from: from || gateway_config['TWILIO_PHONE_NUMBER'],
                             message: message).validate
  end

  def gateway_config
    Hulaki::Config.new.parse['sms']['gateway']
  end
end
