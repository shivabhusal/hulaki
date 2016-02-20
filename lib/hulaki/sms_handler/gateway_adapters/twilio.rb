class Hulaki::Twilio
  def initialize(params = {})
    @config = params[:config]
  end

  def send

  end
  class << self
    @@mode = 'live'
    attr_accessor :mode
  end
end