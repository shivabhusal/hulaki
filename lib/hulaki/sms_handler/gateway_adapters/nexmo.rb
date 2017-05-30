require 'nexmo'

class Hulaki::Nexmo
  attr_reader :to, :from, :message, :client

  def initialize(params = {})
    @to      = params[:to]
    @message = params[:message]

    @config  = params[:config]
    @from    = params.fetch(:from, @config['from'])
    return true if ENV['mode'] == 'test'
    @client  = Nexmo::Client.new(key: @config['API_KEY'], secret: @config['API_SECRET'])

  end

  def send
    return true if ENV['mode'] == 'test'
    client.send_message(from: from, to: to, text: message)
  end
end
