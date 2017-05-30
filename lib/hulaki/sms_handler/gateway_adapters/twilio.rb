require 'twilio-ruby'

class Hulaki::Twilio
  attr_reader :to, :from, :message

  def initialize(params = {})
    @to      = params[:to]
    @message = params[:message]

    @config  = params[:config]
    @from    = @config['ACCOUNT_PHONE_NUMBER']
    @client  = Twilio::REST::Client.new @config['API_KEY'],
                                       @config['API_SECRET']
  end

  def send
    return true if ENV['mode'] == 'test'
    @client.messages.create(
        from: from,
        to: to,
        body: message
    )
  end
end
