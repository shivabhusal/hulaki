class Hulaki::SmsHandler
  VALID_GATEWAY = ['twilio', 'nexmo', 'sparrow']
  attr_reader :gateway, :to, :from, :message

  def initialize(params = {})
    @to      = params.fetch(:to, params[:recipient])
    @from    = params.fetch(:from, params[:sender])
    @message = params.fetch(:message, params[:msg])

    explicit_gateway = params[:gateway] && VALID_GATEWAY.include?(params[:gateway].downcase) && params[:gateway].downcase

    @gateway_name = explicit_gateway || get_default_gateway_name
    @gateway      = get_gateway
  end

  def send
    verify_details
    @gateway.send
  end

  private

  def get_gateway
    config = gateway_config
    klass  = @gateway_name.to_s.capitalize

    eval("Hulaki::#{klass}").new(
        {
            :config  => gateway_config,
            :to      => to,
            :from    => from || gateway_config['from'],
            :message => message
        })

  rescue SyntaxError => e
    raise Hulaki::InvalidSmsGateway, 'Please choose a valid sms gateway'
  end

  def verify_details
    Hulaki::SmsValidator.new(to: to,
                             from: from || gateway_config['ACCOUNT_PHONE_NUMBER'],
                             message: message).validate
  end

  def get_default_gateway_name
      Hulaki::Config['sms'].each do|key, value|
        return key if value['default'] == true
      end

      # If no default defined in the config; pick the last one
      Hulaki::Config['sms'].keys.last
  end

  def gateway_config
    @gateway_config ||= Hulaki::Config['sms'][@gateway_name]
  end
end
