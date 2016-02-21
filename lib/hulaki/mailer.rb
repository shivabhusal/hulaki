class Hulaki::Mailer
  def initialize(params={})
    configure
    @reciever = params[:to]
    @sender = @env["from"]
    sender_email = @env["user_name"]
    @message = params[:body]
    @sub = params[:sub]
    validate(@reciever, sender_email, @message)
  end
  def deliver
    @msg.deliver
    "sent"
  end
  private
  def configure
    @env = Hulaki::Config.new.parse["email"]
    address = @env["address"]
    port = @env["port"]
    domain=@env["domain"]
    user_name = @env["user_name"]
    password = @env["password"]
    authentication =  @env["authentication"]
    Mail.defaults do
      delivery_method :smtp,
      {
       :address              => address,
       :port                 => port,
       :domain               => domain,
       :user_name            => user_name,
       :password             => password,
       :authentication       => authentication,
       :enable_starttls_auto => true
     }
   end
  end
  def create_mail
    @msg = Mail.new({
      :to => @reciever,
      :from=> @sender,
      :subject=> @sub,
      :body=> @message
    })
    self.deliver
  end
  def validate(reciever, sender, message)
    validator = Hulaki::EmailValidator.new(from: reciever, to: sender, message: message)
    errors = validator.validates_format && validator.validates_presence
    if(errors.empty?)
      create_mail
    else
      errors
    end
  end
end
