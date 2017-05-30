require 'mail'

class Hulaki::Mailer
  attr_reader :params, :config

  TEMPLATE_PATH =  ENV['template_path'] || '~/hulaki/template.html.erb'

  def initialize(params={})
    @params     = params
    @config     = Hulaki::Config["email"]
  end

  def deliver
    # Fixme: validation has no purpose for the time being
    validate(@reciever, config["from"], params[:message])
    configure_defaults
    prepare_email
    @mail.deliver
    "sent"
  end

  private
  def prepare_email
    email_body = params[:message]

    # sender set from command-line will take precedence over that in `config.yml`
    from       = params[:from] || config["from"]
    to         = params[:to]
    subject    = params[:subject]

    if config['use_template'] == true
      content = ERB.new(File.read(File.expand_path(TEMPLATE_PATH))).result(binding)
    else
      content = email_body
    end

    @mail = Mail.new do
      to        to
      from      from
      subject   subject

      html_part do
        content_type 'text/html; charset=UTF-8'
        body          content
      end
    end
  end

  def configure_defaults
    # instance variables are not available inside the block below; so
    # localizing the variable
    env = @config
    delivery_mode = ENV['mode'] == 'test' ? 'test' : :smtp
    Mail.defaults do
      delivery_method delivery_mode,
                      {
                          :address              => env["address"],
                          :port                 => env["port"],
                          :domain               => env["domain"],
                          :user_name            => env["user_name"],
                          :password             => env["password"],
                          :authentication       => env["authentication"],
                          :enable_starttls_auto => true
                      }
    end
  end

  # returns [Hash] Error
  def validate(reciever, sender, message)
    validator = Hulaki::EmailValidator.new(from: reciever, to: sender, message: message)
    validator.validates_format && validator.validates_presence
  end
end
