module Hulaki::Logger
  def log(message, color = :green)
    puts message.send(color)
  end

  module_function :log
end
