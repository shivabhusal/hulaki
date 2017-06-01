require 'hulaki/version.rb'
begin
  require 'pry'
rescue LoadError
  # No matter if its production
end


path = File.expand_path('../hulaki/', __FILE__)
Dir["#{path}/**/*.rb"].each{ |f| require f }
