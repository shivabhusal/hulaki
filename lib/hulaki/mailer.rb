class Hulaki::Mailer
  def initialize(params={})
    configure
    binding.pry
    @msg = Mail.new({
      :to => params[:to],
      :from=> 'shishir',
      :subject=> params[:sub],
      :body=> params[:body]
    })
  end
  def deliver
    @msg.deliver
  end
  private
  def configure
    Mail.defaults do
      delivery_method :smtp,
      {
       :address              => "smtp.gmail.com",
       :port                 => 587,
       :domain               => 'gmail.com',
       :user_name            => ENV["GMAIL_USERNAME"],
       :password             => ENV["GMAIL_PASSWORD"],
       :authentication       => :plain,
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
