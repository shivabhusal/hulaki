class Hulaki::Mailer
  def initialize(params={})
    configure
    sender = @env["from"]
    @msg = Mail.new({
      :to => params[:to],
      :from=> sender,
      :subject=> params[:sub],
      :body=> params[:body]
    })
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
       :authentication       =>authentication,
       :enable_starttls_auto => true
     }
   end
  end
end


#
# msg = Mail.new({
#   :to => params[:to],
#   :subject=> params[:sub],
#   :body=> params[:body],
# })
#   m = Mail.new do
#     to 'sis.ccr@gmail.com'
#     from 'sis.ccr@gmail.com'
#     subject 'please have a look at this'
#     body 'This is the body'
#   end
# #
#     Mail.defaults do
#       delivery_method :smtp, { :address              => "smtp.gmail.com",
#                                :port                 => 587,
#                                :domain               => 'gmail.com',
#                                :user_name            => ENV["GMAIL_USERNAME"],
#                                :password             => ENV["GMAIL_PASSWORD"],
#                                :authentication       => :plain,
#                                :enable_starttls_auto => true  }
#                              end
